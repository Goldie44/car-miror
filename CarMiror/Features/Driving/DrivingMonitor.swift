import Foundation
import Observation

@MainActor
@Observable
final class DrivingMonitor {
    private(set) var state: DrivingState = .parked
    private(set) var access: MotionAccess

    @ObservationIgnored private let provider: MotionActivityProviding
    @ObservationIgnored private let now: () -> Date
    @ObservationIgnored private var detector = DrivingDetector()
    @ObservationIgnored private var isStarted = false
    @ObservationIgnored private var pendingReevaluation: Task<Void, Never>?

    init(provider: MotionActivityProviding, now: @escaping () -> Date = Date.init) {
        self.provider = provider
        self.now = now
        self.access = provider.access
    }

    /// Safe to call again each time the app becomes active: it refreshes the permission status
    /// (the author may have answered the prompt or changed it in Réglages).
    func start() {
        access = provider.access
        guard !isStarted, access == .granted || access == .notDetermined else { return }
        isStarted = true
        provider.startUpdates { [weak self] sample in
            self?.handle(sample)
        }
    }

    private func handle(_ sample: MotionSample) {
        detector.ingest(sample)
        reevaluate()
    }

    private func reevaluate() {
        let current = now()
        state = detector.state(at: current)

        pendingReevaluation?.cancel()
        guard let next = detector.nextChange(after: current) else { return }
        pendingReevaluation = Task { [weak self] in
            try? await Task.sleep(for: .seconds(next.timeIntervalSince(current)))
            guard !Task.isCancelled else { return }
            self?.reevaluate()
        }
    }
}
