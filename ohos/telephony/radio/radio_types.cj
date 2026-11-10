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

import ohos.labels.APILevel
import std.deriving.Derive

/**
 * Enumerates radio access technologies.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public enum RadioTechnology {

    /**
     * Unknown RAT
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyUnknown
    |

    /**
     * Global System for Mobile Communication (GSM)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyGsm
    |

    /**
     * Single-Carrier Radio Transmission Technology (1XRTT)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnology1xrtt
    |

    /**
     * Wideband Code Division Multiple Access (WCDMA)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyWcdma
    |

    /**
     * High Speed Packet Access (HSPA)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyHspa
    |

    /**
     * Evolved High Speed Packet Access (HSPA+)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyHspap
    |

    /**
     * TD-SCDMA.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyTdScdma
    |

    /**
     * Evolution-Data Optimized (EVDO)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyEvdo
    |

    /**
     * Evolved High Rate Package Data (EHRPD)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyEhrpd
    |

    /**
     * Long Term Evolution (LTE)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyLte
    |

    /**
     * Long Term Evolution_Carrier Aggregation (LTE_CA)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyLteCa
    |

    /**
     * Industrial Wireless LAN (IWLAN)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyIwlan
    |

    /**
     * New Radio (NR)
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RadioTechnologyNr
    | ...
    static func fromNative(value: Int32): RadioTechnology {
        match (value) {
            case 0 => RadioTechnologyUnknown
            case 1 => RadioTechnologyGsm
            case 2 => RadioTechnology1xrtt
            case 3 => RadioTechnologyWcdma
            case 4 => RadioTechnologyHspa
            case 5 => RadioTechnologyHspap
            case 6 => RadioTechnologyTdScdma
            case 7 => RadioTechnologyEvdo
            case 8 => RadioTechnologyEhrpd
            case 9 => RadioTechnologyLte
            case 10 => RadioTechnologyLteCa
            case 11 => RadioTechnologyIwlan
            case 12 => RadioTechnologyNr
            case _ => RadioTechnologyUnknown
        }
    }
}

/**
 * Enumerates network types.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public enum NetworkType {

    /**
     * Unknown network.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NetworkTypeUnknown
    |

    /**
     * GSM network.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NetworkTypeGsm
    |

    /**
     * CDMA network.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NetworkTypeCdma
    |

    /**
     * WCDMA network.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NetworkTypeWcdma
    |

    /**
     * TD-SCDMA network.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NetworkTypeTdscdma
    |

    /**
     * LTE network.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NetworkTypeLte
    |

    /**
     * NR network.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NetworkTypeNr
    | ...
    static func fromNative(value: Int32): NetworkType {
        match (value) {
            case 0 => NetworkTypeUnknown
            case 1 => NetworkTypeGsm
            case 2 => NetworkTypeCdma
            case 3 => NetworkTypeWcdma
            case 4 => NetworkTypeTdscdma
            case 5 => NetworkTypeLte
            case 6 => NetworkTypeNr
            case _ => NetworkTypeUnknown
        }
    }
}

/**
 * Defines the network registration status of the device.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public enum RegState {

    /**
     * The device cannot use any services, including data, SMS, and call services.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RegStateNoService
    |

    /**
     * The device can use services properly, including data, SMS, and call services.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RegStateInService
    |

    /**
     * The device can use only the emergency call service.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RegStateEmergencyCallOnly
    |

    /**
     * The device cannot communicate with the network because the cellular radio service is disabled or the modem is
     * powered off.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    RegStatePowerOff
    | ...
    static func fromNative(value: Int32): RegState {
        match (value) {
            case 0 => RegStateNoService
            case 1 => RegStateInService
            case 2 => RegStateEmergencyCallOnly
            case 3 => RegStatePowerOff
            case _ => RegStateNoService
        }
    }
}

/**
 * Enumerates NSA network states.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public enum NsaState {

    /**
     * The device is in idle or connected state in an LTE cell that does not support NSA.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NsaStateNotSupport
    |

    /**
     * The device is in the idle state in an LTE cell that supports NSA but not NR coverage detection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NsaStateNoDetect
    |

    /**
     * The device is connected to the LTE network in an LTE cell that supports NSA and NR coverage detection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NsaStateConnectedDetect
    |

    /**
     * The device is in the idle state in an LTE cell that supports NSA and NR coverage detection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NsaStateIdleDetect
    |

    /**
     * The device is connected to the LTE/NR network in an LTE cell that supports NSA.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NsaStateDualConnected
    |

    /**
     * The device is idle or connected to the NG-RAN cell when being attached to the 5G Core.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NsaStateSaAttached
    | ...
    static func fromNative(value: Int32): NsaState {
        match (value) {
            case 1 => NsaStateNotSupport
            case 2 => NsaStateNoDetect
            case 3 => NsaStateConnectedDetect
            case 4 => NsaStateIdleDetect
            case 5 => NsaStateDualConnected
            case 6 => NsaStateSaAttached
            case _ => NsaStateNotSupport
        }
    }
}

/**
 * Enumerates network selection modes.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public enum NetworkSelectionMode {

    /**
     * Unknown network selection mode.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NetworkSelectionUnknown
    |

    /**
     * Automatic network selection mode.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NetworkSelectionAutomatic
    |

    /**
     * Manual network selection mode.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    NetworkSelectionManual
    | ...
    static func fromNative(value: Int32): NetworkSelectionMode {
        match (value) {
            case 0 => NetworkSelectionUnknown
            case 1 => NetworkSelectionAutomatic
            case 2 => NetworkSelectionManual
            case _ => NetworkSelectionUnknown
        }
    }
}

/**
 * Defines the radio access technology for the packet switched (PS) or circuit switched (CS) network.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public class NetworkRadioTech {
    private let networkRadioTechImpl: NetworkRadioTechImpl

    init(psRadioTech: RadioTechnology, csRadioTech: RadioTechnology) {
        this.networkRadioTechImpl = NetworkRadioTechImpl(psRadioTech, csRadioTech)
    }

    /**
     * PS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop psRadioTech: RadioTechnology {
        get() { this.networkRadioTechImpl.psRadioTech }
        set(value) { this.networkRadioTechImpl.psRadioTech = value }
    }

    /**
     * CS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop csRadioTech: RadioTechnology {
        get() { this.networkRadioTechImpl.csRadioTech }
        set(value) { this.networkRadioTechImpl.csRadioTech = value }
    }

}

/**
 * Defines the signal strength.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public class SignalInformation {
    private let signalInformationImpl: SignalInformationImpl

    init(signalType: NetworkType, signalLevel: Int32, dBm: Int32) {
        this.signalInformationImpl = SignalInformationImpl(signalType, signalLevel, dBm)
    }

    /**
     * Signal strength type.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop signalType: NetworkType {
        get() { this.signalInformationImpl.signalType }
        set(value) { this.signalInformationImpl.signalType = value }
    }

    /**
     * Signal strength level. The value range is [0, 5]. If the value is out of range, an error is returned.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop signalLevel: Int32 {
        get() { this.signalInformationImpl.signalLevel }
        set(value) { this.signalInformationImpl.signalLevel = value }
    }

    /**
     * Signal strength. The value range is [–140, 140]. If the value is out of range, an error is returned.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop dBm: Int32 {
        get() { this.signalInformationImpl.dBm }
        set(value) { this.signalInformationImpl.dBm = value }
    }

}

/**
 * Defines the network status.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Telephony.CoreService"
]
public class NetworkState {
    private let networkStateImpl: NetworkStateImpl

    init(longOperatorName: String, shortOperatorName: String, plmnNumeric: String, isRoaming: Bool, regState: RegState, cfgTech: RadioTechnology, nsaState: NsaState, isCaActive: Bool, isEmergency: Bool) {
        this.networkStateImpl = NetworkStateImpl(
            longOperatorName, shortOperatorName, plmnNumeric, isRoaming,
            regState, cfgTech, nsaState, isCaActive, isEmergency)
    }

    /**
     * Long carrier name of the registered network.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop longOperatorName: String {
        get() { this.networkStateImpl.longOperatorName }
        set(value) { this.networkStateImpl.longOperatorName = value }
    }

    /**
     * Short carrier name of the registered network.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop shortOperatorName: String {
        get() { this.networkStateImpl.shortOperatorName }
        set(value) { this.networkStateImpl.shortOperatorName = value }
    }

    /**
     * PLMN code of the registered network.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop plmnNumeric: String {
        get() { this.networkStateImpl.plmnNumeric }
        set(value) { this.networkStateImpl.plmnNumeric = value }
    }

    /**
     * Whether the user is roaming.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop isRoaming: Bool {
        get() { this.networkStateImpl.isRoaming }
        set(value) { this.networkStateImpl.isRoaming = value }
    }

    /**
     * Network registration status of the device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop regState: RegState {
        get() { this.networkStateImpl.regState }
        set(value) { this.networkStateImpl.regState = value }
    }

    /**
     * RAT of the device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop cfgTech: RadioTechnology {
        get() { this.networkStateImpl.cfgTech }
        set(value) { this.networkStateImpl.cfgTech = value }
    }

    /**
     * NSA network registration status of the device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop nsaState: NsaState {
        get() { this.networkStateImpl.nsaState }
        set(value) { this.networkStateImpl.nsaState = value }
    }

    /**
     * CA status.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop isCaActive: Bool {
        get() { this.networkStateImpl.isCaActive }
        set(value) { this.networkStateImpl.isCaActive = value }
    }

    /**
     * Whether only emergency calls are allowed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Telephony.CoreService"
    ]
    public mut prop isEmergency: Bool {
        get() { this.networkStateImpl.isEmergency }
        set(value) { this.networkStateImpl.isEmergency = value }
    }

}

class NetworkRadioTechImpl {
    var psRadioTech: RadioTechnology
    var csRadioTech: RadioTechnology

    init(psRadioTech: RadioTechnology, csRadioTech: RadioTechnology) {
        this.psRadioTech = psRadioTech
        this.csRadioTech = csRadioTech
    }
}

class SignalInformationImpl {
    var signalType: NetworkType
    var signalLevel: Int32
    var dBm: Int32

    init(signalType: NetworkType, signalLevel: Int32, dBm: Int32) {
        this.signalType = signalType
        this.signalLevel = signalLevel
        this.dBm = dBm
    }
}

class NetworkStateImpl {
    var longOperatorName: String
    var shortOperatorName: String
    var plmnNumeric: String
    var isRoaming: Bool
    var regState: RegState
    var cfgTech: RadioTechnology
    var nsaState: NsaState
    var isCaActive: Bool
    var isEmergency: Bool

    init(longOperatorName: String, shortOperatorName: String, plmnNumeric: String,
        isRoaming: Bool, regState: RegState, cfgTech: RadioTechnology,
        nsaState: NsaState, isCaActive: Bool, isEmergency: Bool) {
        this.longOperatorName = longOperatorName
        this.shortOperatorName = shortOperatorName
        this.plmnNumeric = plmnNumeric
        this.isRoaming = isRoaming
        this.regState = regState
        this.cfgTech = cfgTech
        this.nsaState = nsaState
        this.isCaActive = isCaActive
        this.isEmergency = isEmergency
    }
}
