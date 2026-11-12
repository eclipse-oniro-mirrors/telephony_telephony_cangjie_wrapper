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

// Internal bridges for system-provided Cangjie APIs; compatibility packages use their legacy FFI entries.
foreign {
    func FfiTelephonyRadioGetRadioTechSync(slotId: Int32): CNetworkRadioTech
    func FfiOhosTelephonyRadioGetNetworkState(slotId: Int32, errCode: CPointer<Int32>): CNetworkState
    func FfiOhosTelephonyRadioGetNetworkSelectionMode(slotId: Int32, errCode: CPointer<Int32>): Int32
    func FfiTelephonyRadioGetISOCountryCodeForNetworkSync(slotId: Int32): CString
    func FfiTelephonyRadioFreeCString(value: CString): Unit
    func FfiOhosTelephonyRadioGetPrimarySlotId(errCode: CPointer<Int32>): Int32
    func FfiTelephonyRadioIsNRSupported(): Bool
}

@C
struct CNetworkRadioTech {
    CNetworkRadioTech(let psRadioTech: Int32, let csRadioTech: Int32) {}

    func toObject(): NetworkRadioTech {
        NetworkRadioTech(RadioTechnology.fromNative(psRadioTech), RadioTechnology.fromNative(csRadioTech))
    }
}

@C
struct CNetworkState {
    CNetworkState(
        let longOperatorName: CString,
        let shortOperatorName: CString,
        let plmnNumeric: CString,
        let isRoaming: Bool,
        let regState: Int32,
        let cfgTech: Int32,
        let nsaState: Int32,
        let isCaActive: Bool,
        let isEmergency: Bool
    ) {}

    // Copies native strings into the result and releases them even if conversion throws.
    func toObjectAndFree(): NetworkState {
        try {
            NetworkState(
                stringFromNative(longOperatorName),
                stringFromNative(shortOperatorName),
                stringFromNative(plmnNumeric),
                isRoaming,
                RegState.fromNative(regState),
                RadioTechnology.fromNative(cfgTech),
                NsaState.fromNative(nsaState),
                isCaActive,
                isEmergency
            )
        } finally {
            freeStrings()
        }
    }

    func freeStrings(): Unit {
        unsafe {
            if (!longOperatorName.isNull()) { FfiTelephonyRadioFreeCString(longOperatorName) }
            if (!shortOperatorName.isNull()) { FfiTelephonyRadioFreeCString(shortOperatorName) }
            if (!plmnNumeric.isNull()) { FfiTelephonyRadioFreeCString(plmnNumeric) }
        }
    }
}

func stringFromNative(value: CString): String {
    unsafe {
        if (value.isNull()) { "" } else { value.toString() }
    }
}
