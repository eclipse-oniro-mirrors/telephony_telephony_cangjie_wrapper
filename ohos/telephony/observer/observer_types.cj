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

import ohos.labels.APILevel
import ohos.telephony.call.CallState
import ohos.telephony.sim.{CardType, SimState}
import std.deriving.Derive

@!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
public class SimStateData {
    private let simStateDataImpl: SimStateDataImpl

    init(cardType: CardType, state: SimState, reason: LockReason) {
        this.simStateDataImpl = SimStateDataImpl(cardType, state, reason)
    }

    @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    public mut prop cardType: CardType {
        get() { this.simStateDataImpl.cardType }
        set(value) { this.simStateDataImpl.cardType = value }
    }

    @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    public mut prop state: SimState {
        get() { this.simStateDataImpl.state }
        set(value) { this.simStateDataImpl.state = value }
    }

    @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    public mut prop reason: LockReason {
        get() { this.simStateDataImpl.reason }
        set(value) { this.simStateDataImpl.reason = value }
    }
}

@!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
public class CallStateInfo {
    private let callStateInfoImpl: CallStateInfoImpl

    init(state: CallState, number: String) {
        this.callStateInfoImpl = CallStateInfoImpl(state, number)
    }

    @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    public mut prop state: CallState {
        get() { this.callStateInfoImpl.state }
        set(value) { this.callStateInfoImpl.state = value }
    }

    @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    public mut prop number: String {
        get() { this.callStateInfoImpl.number }
        set(value) { this.callStateInfoImpl.number = value }
    }
}

@!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
public class ObserverOptions {
    private let observerOptionsImpl: ObserverOptionsImpl

    @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    public init(slotId!: ?Int32 = None) {
        this.observerOptionsImpl = ObserverOptionsImpl(slotId ?? 0)
    }

    @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    public mut prop slotId: Int32 {
        get() { this.observerOptionsImpl.slotId }
        set(value) { this.observerOptionsImpl.slotId = value }
    }
}

@Derive[ToString, Equatable]
@!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
public enum LockReason {
    @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimNone
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimPin
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimPuk
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimPnPin
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimPnPuk
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimPuPin
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimPuPuk
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimPpPin
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimPpPuk
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimPcPin
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimPcPuk
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimSimPin
    | @!APILevel[since: "26.1.0", syscap: "SystemCapability.Telephony.StateRegistry"]
    SimSimPuk
    | ...

    static func fromNative(value: Int32): LockReason {
        match (value) {
            case 0 => SimNone
            case 1 => SimPin
            case 2 => SimPuk
            case 3 => SimPnPin
            case 4 => SimPnPuk
            case 5 => SimPuPin
            case 6 => SimPuPuk
            case 7 => SimPpPin
            case 8 => SimPpPuk
            case 9 => SimPcPin
            case 10 => SimPcPuk
            case 11 => SimSimPin
            case 12 => SimSimPuk
            case _ => SimNone
        }
    }
}

class SimStateDataImpl {
    var cardType: CardType
    var state: SimState
    var reason: LockReason

    init(cardType: CardType, state: SimState, reason: LockReason) {
        this.cardType = cardType
        this.state = state
        this.reason = reason
    }
}

class CallStateInfoImpl {
    var state: CallState
    var number: String

    init(state: CallState, number: String) {
        this.state = state
        this.number = number
    }
}

class ObserverOptionsImpl {
    var slotId: Int32

    init(slotId: Int32) {
        this.slotId = slotId
    }
}
