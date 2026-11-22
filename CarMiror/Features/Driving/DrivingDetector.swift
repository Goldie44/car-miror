import Foundation

/// Turns motion samples into "moving" or "parked".
/// Once in a car, a stop only counts as parked after `parkDelay`, so video does not come back at every red light.
struct DrivingDetector {
    static let parkDelay: TimeInterval = 120

    private var isInCar = false
    private var stoppedSince: Date?

    mutating func ingest(_ sample: MotionSample) {
        switch sample.kind {
        case .driving:
            isInCar = true
            stoppedSince = nil
        case .stationary:
            if isInCar, stoppedSince == nil {
                stoppedSince = sample.date
            }
        case .onFoot:
            isInCar = false
            stoppedSince = nil
        case .unknown:
            break
        }
    }

    func state(at now: Date) -> DrivingState {
        guard isInCar else { return .parked }
        if let stoppedSince, now.timeIntervalSince(stoppedSince) >= Self.parkDelay {
            return .parked
        }
        return .moving
    }

    /// When the state will flip on its own without a new sample, if it will.
    func nextChange(after now: Date) -> Date? {
        guard isInCar, let stoppedSince else { return nil }
        let parkedAt = stoppedSince.addingTimeInterval(Self.parkDelay)
        return parkedAt > now ? parkedAt : nil
    }
}
