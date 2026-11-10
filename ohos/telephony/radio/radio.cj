/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

package ohos.telephony.radio

import ohos.business_exception.{AsyncCallback, BusinessException, getUniversalErrorMsg}
import ohos.labels.APILevel

func radioError(code: Int32, interfaceName: String): BusinessException {
    match (code) {
        case 201 =>
            let message = if (interfaceName == "getNetworkState") {
                "Permission denied. ${interfaceName} requires ohos.permission.GET_NETWORK_INFO."
            } else {
                "Permission denied."
            }
            BusinessException(code, message)
        case 202 => BusinessException(code, "Non-system applications use system APIs.")
        case 8300001 => BusinessException(code, "Invalid parameter value.")
        case 8300002 => BusinessException(code, "Operation failed. Cannot connect to service.")
        case 8300003 => BusinessException(code, "System internal error.")
        case 8300004 => BusinessException(code, "Do not have sim card.")
        case 8300005 => BusinessException(code, "Airplane mode is on.")
        case 8300006 => BusinessException(code, "Network not in service.")
        case 8300011 => BusinessException(code, "Policy is disabled.")
        case 8300999 => BusinessException(code, "Unknown error code.")
        case _ => BusinessException(code, getUniversalErrorMsg(code) ?? "Unknown error code.")
    }
}

/**
 * Obtains the ISO country code of the network with which the SIM card in the specified slot is registered.
 *
 * @param { Int32 } slotId - Card slot ID.
 *     - **0**: card slot 1.
 *     - **1**: card slot 2.
 * @returns { String } ISO country code of the network, for example, **CN** (China). If the device is not registered
 *     with any network, an empty string is returned.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public func getISOCountryCodeForNetworkSync(slotId: Int32): String {
    unsafe {
        let nativeValue = FfiTelephonyRadioGetISOCountryCodeForNetworkSync(slotId)
        try {
            stringFromNative(nativeValue)
        } finally {
            if (!nativeValue.isNull()) { FfiTelephonyRadioFreeCString(nativeValue) }
        }
    }
}

/**
 * Obtains the network selection mode of the SIM card in the specified slot. This API uses an asynchronous callback to
 * return the result.
 *
 * @param { Int32 } slotId - Card slot ID.
 *     - **0**: card slot 1.
 *     - **1**: card slot 2.
 * @param { AsyncCallback<NetworkSelectionMode> } callback - Callback used to return the result.
 * @throws { BusinessException } 8300001 - Invalid parameter value.
 * @throws { BusinessException } 8300002 - Service connection failed.
 * @throws { BusinessException } 8300003 - System internal error.
 * @throws { BusinessException } 8300999 - Unknown error.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService",
    throwexception: true
]
public func getNetworkSelectionMode(slotId: Int32, callback: AsyncCallback<NetworkSelectionMode>): Unit {
    spawn {
        var errorCode = 0i32
        let value = unsafe { FfiOhosTelephonyRadioGetNetworkSelectionMode(slotId, inout errorCode) }
        if (errorCode != 0) {
            callback(radioError(errorCode, "getNetworkSelectionMode"), None<NetworkSelectionMode>)
        } else {
            callback(None<BusinessException>, Some(NetworkSelectionMode.fromNative(value)))
        }
    }
}

/**
 * Obtains the network status of the SIM card in the specified slot. This API uses an asynchronous callback to return
 * the result.
 *
 * @param { Int32 } slotId - Card slot ID.
 *     - **0**: card slot 1.
 *     - **1**: card slot 2.
 * @param { AsyncCallback<NetworkState> } callback - Callback used to return the result.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 8300001 - Invalid parameter value.
 * @throws { BusinessException } 8300002 - Service connection failed.
 * @throws { BusinessException } 8300003 - System internal error.
 * @throws { BusinessException } 8300999 - Unknown error.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.GET_NETWORK_INFO",
    syscap: "SystemCapability.Telephony.CoreService",
    throwexception: true
]
public func getNetworkState(slotId: Int32, callback: AsyncCallback<NetworkState>): Unit {
    spawn {
        var errorCode = 0i32
        let nativeValue = unsafe { FfiOhosTelephonyRadioGetNetworkState(slotId, inout errorCode) }
        if (errorCode != 0) {
            nativeValue.freeStrings()
            callback(radioError(errorCode, "getNetworkState"), None<NetworkState>)
        } else {
            let result = nativeValue.toObjectAndFree()
            callback(None<BusinessException>, Some(result))
        }
    }
}

/**
 * Obtains the network status. This API uses an asynchronous callback to return the result.
 *
 * @param { AsyncCallback<NetworkState> } callback - Callback used to return the result.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 8300001 - Invalid parameter value.
 * @throws { BusinessException } 8300002 - Service connection failed.
 * @throws { BusinessException } 8300003 - System internal error.
 * @throws { BusinessException } 8300999 - Unknown error.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.GET_NETWORK_INFO",
    syscap: "SystemCapability.Telephony.CoreService",
    throwexception: true
]
public func getNetworkState(callback: AsyncCallback<NetworkState>): Unit {
    getNetworkState(0i32, callback)
}

/**
 * Obtains the ID of the slot in which the primary card is located. This API uses an asynchronous callback to return
 * the result.
 *
 * @param { AsyncCallback<Int32> } callback - Callback used to return the result.
 * @throws { BusinessException } 8300001 - Invalid parameter value.
 * @throws { BusinessException } 8300002 - Service connection failed.
 * @throws { BusinessException } 8300003 - System internal error.
 * @throws { BusinessException } 8300999 - Unknown error.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService",
    throwexception: true
]
public func getPrimarySlotId(callback: AsyncCallback<Int32>): Unit {
    spawn {
        var errorCode = 0i32
        let value = unsafe { FfiOhosTelephonyRadioGetPrimarySlotId(inout errorCode) }
        if (errorCode != 0) {
            callback(radioError(errorCode, "getPrimarySlotId"), None<Int32>)
        } else {
            callback(None<BusinessException>, Some(value))
        }
    }
}

/**
 * Obtains the RAT used in the CS and PS domains for the SIM card in the specified slot. The CS domain refers to the
 * Circuit Switched domain, and the PS domain refers to the Packet Switched domain.
 *
 * @param { Int32 } slotId - Card slot ID.
 *     - **0**: card slot 1.
 *     - **1**: card slot 2.
 * @returns { NetworkRadioTech } RAT used in the CS and PS domains. The CS domain refers to the Circuit Switched
 *     domain, and the PS domain refers to the Packet Switched domain.
 *     If the slot ID is invalid or either query fails (including permission denial), both fields are
 *     RadioTechnology.RadioTechnologyUnknown. These query failures do not throw BusinessException.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.GET_NETWORK_INFO",
    syscap: "SystemCapability.Telephony.CoreService"
]
public func getRadioTechSync(slotId: Int32): NetworkRadioTech {
    unsafe {
        let value = FfiTelephonyRadioGetRadioTechSync(slotId)
        value.toObject()
    }
}

/**
 * Checks whether the current device supports NR.
 *
 * @returns { Bool } Returns **true** if the current device supports NR; returns **false** otherwise.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public func isNRSupported(): Bool {
    unsafe { FfiTelephonyRadioIsNRSupported() }
}
