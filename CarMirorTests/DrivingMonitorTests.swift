import XCTest
@testable import CarMiror

@MainActor
private final class FakeMotionProvider: MotionActivityProviding {
    var access: MotionAccess
    private(set) var startCount = 0
    private var handler: (@MainActor (MotionSample) -> Void)?

    init(access: MotionAccess) {
        self.access = access
    }

    func startUpdates(_ handler: @escaping @MainActor (MotionSample) -> Void) {
        startCount += 1
        self.handler = handler
    }

    func send(_ sample: MotionSample) {
        handler?(sample)
    }
}

final class DrivingMonitorTests: XCTestCase {
    private let now = Date(timeIntervalSince1970: 1_000_000)

    @MainActor
    func testDrivingSampleMakesTheMonitorMove() {
        let provider = FakeMotionProvider(access: .granted)
        let monitor = DrivingMonitor(provider: provider, now: { self.now })
        monitor.start()

        provider.send(MotionSample(kind: .driving, date: now))

        XCTAssertEqual(monitor.state, .moving)
    }

    @MainActor
    func testStartingTwiceSubscribesOnce() {
        let provider = FakeMotionProvider(access: .granted)
        let monitor = DrivingMonitor(provider: provider, now: { self.now })

        monitor.start()
        monitor.start()

        XCTAssertEqual(provider.startCount, 1)
    }

    @MainActor
    func testDeniedAccessDoesNotSubscribeAndStaysParked() {
        let provider = FakeMotionProvider(access: .denied)
        let monitor = DrivingMonitor(provider: provider, now: { self.now })

        monitor.start()

        XCTAssertEqual(provider.startCount, 0)
        XCTAssertEqual(monitor.access, .denied)
        XCTAssertEqual(monitor.state, .parked)
    }

    @MainActor
    func testStartRefreshesAccessAfterThePrompt() {
        let provider = FakeMotionProvider(access: .notDetermined)
        let monitor = DrivingMonitor(provider: provider, now: { self.now })
        monitor.start()

        provider.access = .denied
        monitor.start()

        XCTAssertEqual(monitor.access, .denied)
    }
}
