import XCTest
@testable import CarMiror

final class DrivingDetectorTests: XCTestCase {
    private let start = Date(timeIntervalSince1970: 1_000_000)

    private func at(_ seconds: TimeInterval) -> Date {
        start.addingTimeInterval(seconds)
    }

    private func sample(_ kind: MotionSample.Kind, _ seconds: TimeInterval) -> MotionSample {
        MotionSample(kind: kind, date: at(seconds))
    }

    func testStartsParked() {
        XCTAssertEqual(DrivingDetector().state(at: start), .parked)
    }

    func testDrivingMakesItMove() {
        var detector = DrivingDetector()

        detector.ingest(sample(.driving, 0))

        XCTAssertEqual(detector.state(at: at(1)), .moving)
    }

    func testAShortStopLikeARedLightKeepsItMoving() {
        var detector = DrivingDetector()
        detector.ingest(sample(.driving, 0))

        detector.ingest(sample(.stationary, 10))

        XCTAssertEqual(detector.state(at: at(10 + 90)), .moving)
    }

    func testALongStopCountsAsParked() {
        var detector = DrivingDetector()
        detector.ingest(sample(.driving, 0))

        detector.ingest(sample(.stationary, 10))

        XCTAssertEqual(detector.state(at: at(10 + DrivingDetector.parkDelay)), .parked)
    }

    func testDrivingAgainAfterAStopResetsTheDelay() {
        var detector = DrivingDetector()
        detector.ingest(sample(.driving, 0))
        detector.ingest(sample(.stationary, 10))

        detector.ingest(sample(.driving, 60))
        detector.ingest(sample(.stationary, 100))

        XCTAssertEqual(detector.state(at: at(10 + DrivingDetector.parkDelay)), .moving)
    }

    func testWalkingAwayFromTheCarIsParkedAtOnce() {
        var detector = DrivingDetector()
        detector.ingest(sample(.driving, 0))

        detector.ingest(sample(.onFoot, 30))

        XCTAssertEqual(detector.state(at: at(31)), .parked)
    }

    func testStationaryWithoutDrivingFirstStaysParked() {
        var detector = DrivingDetector()

        detector.ingest(sample(.stationary, 0))

        XCTAssertEqual(detector.state(at: at(1)), .parked)
    }

    func testNextChangeIsWhenTheStopBecomesParked() {
        var detector = DrivingDetector()
        detector.ingest(sample(.driving, 0))
        XCTAssertNil(detector.nextChange(after: at(1)))

        detector.ingest(sample(.stationary, 10))

        XCTAssertEqual(detector.nextChange(after: at(20)), at(10 + DrivingDetector.parkDelay))
        XCTAssertNil(detector.nextChange(after: at(10 + DrivingDetector.parkDelay)))
    }

    func testKindTreatsAStoppedCarAsStationary() {
        XCTAssertEqual(MotionSample.Kind(automotive: true, stationary: true, onFoot: false), .stationary)
        XCTAssertEqual(MotionSample.Kind(automotive: true, stationary: false, onFoot: false), .driving)
        XCTAssertEqual(MotionSample.Kind(automotive: false, stationary: false, onFoot: true), .onFoot)
        XCTAssertEqual(MotionSample.Kind(automotive: false, stationary: false, onFoot: false), .unknown)
    }

    func testOnlyVideoIsHiddenWhileDriving() {
        XCTAssertEqual(LauncherCategory.allCases.filter(\.isHiddenWhileDriving), [.video])
    }
}
