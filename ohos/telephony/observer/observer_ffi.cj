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

import ohos.telephony.call.CallState
import ohos.telephony.radio.{NetworkState, SignalInformation, NetworkType, RadioTechnology, RegState, NsaState}
import ohos.telephony.sim.{CardType, SimState}

foreign {
    func FfiTelephonyObserverOnCCallStateChange(options: CObserverOptions, funcId: Int64): Int32
    func FfiTelephonyObserverOffCCallStateChange(funcId: Int64): Int32
    func FfiTelephonyObserverSubscribeNetworkStateChange(options: CObserverOptions, funcId: Int64): Int32
    func FfiTelephonyObserverUnsubscribeNetworkStateChange(funcId: Int64): Int32
    func FfiTelephonyObserverSubscribeSignalInfoChange(options: CObserverOptions, funcId: Int64): Int32
    func FfiTelephonyObserverUnsubscribeSignalInfoChange(funcId: Int64): Int32
    func FfiTelephonyObserverSubscribeSimStateChange(options: CObserverOptions, funcId: Int64): Int32
    func FfiTelephonyObserverUnsubscribeSimStateChange(funcId: Int64): Int32
    func FfiTelephonyObserverSubscribeIccAccountInfoChange(options: CObserverOptions, funcId: Int64): Int32
    func FfiTelephonyObserverUnsubscribeIccAccountInfoChange(funcId: Int64): Int32
}

@C
struct CObserverOptions {
    CObserverOptions(let slotId: Int32) {}
}

@C
struct CCallStateInfo {
    CCallStateInfo(let state: Int32, let number: CString) {}
}

@C
struct CSimStateData {
    CSimStateData(let cardType: Int32, let state: Int32, let reason: Int32) {}
}

@C
struct CSignalInformation {
    CSignalInformation(let signalType: Int32, let signalLevel: Int32, let dBm: Int32) {}
}

@C
struct CArraySignalInformation {
    CArraySignalInformation(let head: CPointer<CSignalInformation>, let size: Int64) {}
}

@C
struct CObserverNetworkState {
    CObserverNetworkState(
        let longOperatorName: CString, let shortOperatorName: CString, let plmnNumeric: CString,
        let isRoaming: Bool, let regState: Int32, let cfgTech: Int32, let nsaState: Int32,
        let isCaActive: Bool, let isEmergency: Bool
    ) {}
}

func observerString(value: CString): String {
    unsafe { if (value.isNull()) { "" } else { value.toString() } }
}

func callStateFromNative(value: CPointer<Unit>): CallStateInfo {
    unsafe {
        let native = CPointer<CCallStateInfo>(value).read()
        try {
            let state = match (native.state) {
                case 0 => CallState.CallStateIdle
                case 1 => CallState.CallStateRinging
                case 2 => CallState.CallStateOffhook
                case 3 => CallState.CallStateAnswered
                case _ => CallState.CallStateUnknown
            }
            CallStateInfo(state, observerString(native.number))
        } finally {
            if (!native.number.isNull()) { LibC.free(native.number) }
        }
    }
}

func networkStateFromNative(value: CPointer<Unit>): NetworkState {
    unsafe {
        let native = CPointer<CObserverNetworkState>(value).read()
        try {
            NetworkState(
                observerString(native.longOperatorName), observerString(native.shortOperatorName),
                observerString(native.plmnNumeric), native.isRoaming, RegState.fromNative(native.regState),
                RadioTechnology.fromNative(native.cfgTech), NsaState.fromNative(native.nsaState),
                native.isCaActive, native.isEmergency
            )
        } finally {
            if (!native.longOperatorName.isNull()) { LibC.free(native.longOperatorName) }
            if (!native.shortOperatorName.isNull()) { LibC.free(native.shortOperatorName) }
            if (!native.plmnNumeric.isNull()) { LibC.free(native.plmnNumeric) }
        }
    }
}

func signalsFromNative(value: CPointer<Unit>): Array<SignalInformation> {
    unsafe {
        let native = CPointer<CArraySignalInformation>(value).read()
        // The native event handler owns the array; only copy it during this call.
        if (native.size <= 0 || native.head.isNull()) { return Array<SignalInformation>() }
        let head = native.head
        Array<SignalInformation>(native.size, {index =>
            let signal = head.read(index)
            SignalInformation(NetworkType.fromNative(signal.signalType), signal.signalLevel, signal.dBm)
        })
    }
}

func simStateFromNative(value: CPointer<Unit>): SimStateData {
    unsafe {
        let native = CPointer<CSimStateData>(value).read()
        SimStateData(cardTypeFromNative(native.cardType), simStateValue(native.state), LockReason.fromNative(native.reason))
    }
}

func cardTypeFromNative(value: Int32): CardType {
    match (value) {
        case 10 => CardType.SingleModeSimCard
        case 20 => CardType.SingleModeUsimCard
        case 30 => CardType.SingleModeRuimCard
        case 40 => CardType.DualModeCgCard
        case 41 => CardType.CtNationalRoamingCard
        case 42 => CardType.CuDualModeCard
        case 43 => CardType.DualModeTelecomLteCard
        case 50 => CardType.DualModeUgCard
        case 60 => CardType.SingleModeIsimCard
        case _ => CardType.UnknownCard
    }
}

func simStateValue(value: Int32): SimState {
    match (value) {
        case 1 => SimState.SimStateNotPresent
        case 2 => SimState.SimStateLocked
        case 3 => SimState.SimStateNotReady
        case 4 => SimState.SimStateReady
        case 5 => SimState.SimStateLoaded
        case _ => SimState.SimStateUnknown
    }
}
