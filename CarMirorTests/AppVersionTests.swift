import XCTest
@testable import CarMiror

final class AppVersionTests: XCTestCase {
    func testLabelCombinesMarketingVersionAndBuildNumber() {
        let version = AppVersion(marketing: "0.1.0", build: "42")

        XCTAssertEqual(version.label, "v0.1.0 (42)")
    }

    func testMainBundleProvidesARealVersion() {
        let version = AppVersion(bundle: .main)

        XCTAssertNotEqual(version.marketing, "?")
        XCTAssertNotEqual(version.build, "?")
    }
}
