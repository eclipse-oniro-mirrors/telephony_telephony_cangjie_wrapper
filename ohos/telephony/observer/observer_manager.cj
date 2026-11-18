/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.telephony.observer

import ohos.business_exception.{BusinessException, getUniversalErrorMsg}
import ohos.callback_invoke.CallbackObject
import ohos.ffi.Callback1Param
import ohos.hilog.Hilog
import std.collection.ArrayList
import std.sync.Mutex

private let observerMutex = Mutex()
private let observerListeners = ArrayList<ObserverListener>()

private class ObserverListener {
    ObserverListener(let event: String, let slotId: Int32, let callback: CallbackObject,
        let bridge: Callback1Param<CPointer<Unit>, Unit>) {}
}

func observerSlot(options: ?ObserverOptions, callEvent: Bool): Int32 {
    match (options) {
        case Some(value) => value.slotId
        case None => if (callEvent) { -1 } else { 0 }
    }
}

private func checkObserverError(code: Int32): Unit {
    if (code != 0) {
        let message = getUniversalErrorMsg(code) ?? match (code) {
            case 8300001 | 8800001 => ("Invalid parameter value.")
            case 8300002 | 8800002 => ("Service connection failed.")
            case 8300003 | 8800003 => ("System internal error.")
            case _ => ("Unknown telephony observer error.")
        }
        throw BusinessException(code, message)
    }
}

func registerObserver(event: String, callback: CallbackObject, slotId: Int32,
    invoke: (CPointer<Unit>) -> Unit): Unit {
    synchronized(observerMutex) {
        for (listener in observerListeners) {
            if (listener.event == event && listener.slotId == slotId && refEq(listener.callback, callback)) {
                return
            }
        }
        let bridge = Callback1Param<CPointer<Unit>, Unit>({value =>
            // ICC notifications intentionally carry a null payload. No application code runs under observerMutex.
            if (value.isNull() && event != "IccAccountInfoChange") { return }
            try {
                invoke(value)
            } catch (_: Exception) {
                // Keep application exceptions from unwinding across the C ABI; do not log payloads/phone numbers.
                Hilog.error(0, "TelephonyObserver", "Observer callback failed.", [])
            }
        })
        let code = nativeObserverOn(event, slotId, bridge.getID())
        if (code != 0) {
            bridge.destroySelf()
            checkObserverError(code)
        }
        observerListeners.add(ObserverListener(event, slotId, callback, bridge))
    }
}

func unregisterObserver<T>(event: String, callback: ?T): Unit where T <: CallbackObject {
    synchronized(observerMutex) {
        var firstError = 0i32
        var index = 0i64
        while (index < observerListeners.size) {
            let listener = observerListeners[index]
            let matches = match (callback) {
                case Some(value) => refEq(value, listener.callback)
                case None => true
            }
            if (listener.event != event || !matches) {
                index++
                continue
            }
            let code = nativeObserverOff(event, listener.bridge.getID())
            // Native off removes the local entry even when removing the service observer fails.
            observerListeners.remove(at: index)
            if (firstError == 0) { firstError = code }
        }
        checkObserverError(firstError)
    }
}

private func nativeObserverOn(event: String, slotId: Int32, id: Int64): Int32 {
    unsafe {
        let options = CObserverOptions(slotId)
        match (event) {
            case "CallStateChange" => FfiTelephonyObserverOnCCallStateChange(options, id)
            case "NetworkStateChange" => FfiTelephonyObserverOnNetworkStateChangeV2(options, id)
            case "SignalInfoChange" => FfiTelephonyObserverOnSignalInfoChangeV2(options, id)
            case "SimStateChange" => FfiTelephonyObserverOnSimStateChangeV2(options, id)
            case "IccAccountInfoChange" => FfiTelephonyObserverOnIccAccountInfoChangeWithOptions(options, id)
            case _ => 8300001
        }
    }
}

private func nativeObserverOff(event: String, id: Int64): Int32 {
    unsafe {
        match (event) {
            case "CallStateChange" => FfiTelephonyObserverOffCCallStateChange(id)
            case "NetworkStateChange" => FfiTelephonyObserverOffNetworkStateChangeV2(id)
            case "SignalInfoChange" => FfiTelephonyObserverOffSignalInfoChangeV2(id)
            case "SimStateChange" => FfiTelephonyObserverOffSimStateChangeV2(id)
            case "IccAccountInfoChange" => FfiTelephonyObserverOffIccAccountInfoChangeV2(id)
            case _ => 8300001
        }
    }
}
