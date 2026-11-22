import CoreMotion

/// Source of motion samples. A protocol so tests can drive a fake car.
@MainActor
protocol MotionActivityProviding: AnyObject {
    var access: MotionAccess { get }
    func startUpdates(_ handler: @escaping @MainActor (MotionSample) -> Void)
}

@MainActor
final class CoreMotionActivityProvider: MotionActivityProviding {
    private let manager = CMMotionActivityManager()

    var access: MotionAccess {
        guard CMMotionActivityManager.isActivityAvailable() else { return .unavailable }
        switch CMMotionActivityManager.authorizationStatus() {
        case .authorized: return .granted
        case .notDetermined: return .notDetermined
        case .denied, .restricted: return .denied
        @unknown default: return .denied
        }
    }

    /// The first call shows the "Mouvements et forme" permission prompt.
    func startUpdates(_ handler: @escaping @MainActor (MotionSample) -> Void) {
        manager.startActivityUpdates(to: .main) { activity in
            guard let activity, activity.confidence != .low else { return }
            let sample = MotionSample(
                kind: MotionSample.Kind(
                    automotive: activity.automotive,
                    stationary: activity.stationary,
                    onFoot: activity.walking || activity.running || activity.cycling
                ),
                date: activity.startDate
            )
            MainActor.assumeIsolated {
                handler(sample)
            }
        }
    }
}
