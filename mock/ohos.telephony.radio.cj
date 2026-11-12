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

package ohos.telephony.radio

import ohos.business_exception.AsyncCallback
import ohos.labels.APILevel

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public func getISOCountryCodeForNetworkSync(slotId: Int32): String { "" }

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService",
    throwexception: true
]
public func getNetworkSelectionMode(slotId: Int32, callback: AsyncCallback<NetworkSelectionMode>): Unit {
    callback(None, Some(NetworkSelectionMode.NetworkSelectionUnknown))
}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.GET_NETWORK_INFO",
    syscap: "SystemCapability.Telephony.CoreService",
    throwexception: true
]
public func getNetworkState(slotId: Int32, callback: AsyncCallback<NetworkState>): Unit {
    callback(None, Some(NetworkState("", "", "", false, RegState.RegStateNoService,
        RadioTechnology.RadioTechnologyUnknown, NsaState.NsaStateNotSupport, false, false)))
}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.GET_NETWORK_INFO",
    syscap: "SystemCapability.Telephony.CoreService",
    throwexception: true
]
public func getNetworkState(callback: AsyncCallback<NetworkState>): Unit {
    getNetworkState(0i32, callback)
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService",
    throwexception: true
]
public func getPrimarySlotId(callback: AsyncCallback<Int32>): Unit {
    callback(None, Some(0i32))
}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.GET_NETWORK_INFO",
    syscap: "SystemCapability.Telephony.CoreService"
]
public func getRadioTechSync(slotId: Int32): NetworkRadioTech {
    NetworkRadioTech(RadioTechnology.RadioTechnologyUnknown, RadioTechnology.RadioTechnologyUnknown)
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public func isNRSupported(): Bool { false }
