import Foundation

/// One reading of what the phone is doing, independent of Core Motion so the logic can be tested.
struct MotionSample: Equatable {
    enum Kind: Equatable {
        case driving
        case stationary
        case onFoot
        case unknown

        init(automotive: Bool, stationary: Bool, onFoot: Bool) {
            // Core Motion reports "automotive + stationary" when the car is stopped (red light, parking).
            if stationary {
                self = .stationary
            } else if automotive {
                self = .driving
            } else if onFoot {
                self = .onFoot
            } else {
                self = .unknown
            }
        }
    }

    let kind: Kind
    let date: Date
}

enum DrivingState: Equatable {
    case parked
    case moving
}

enum MotionAccess: Equatable {
    case granted
    case notDetermined
    case denied
    case unavailable
}
