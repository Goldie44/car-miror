import XCTest
@testable import CarMiror

final class LauncherAppTests: XCTestCase {
    func testEveryAppHasAnOpenableURL() {
        for app in LauncherApp.all {
            XCTAssertEqual(app.url.scheme, app.scheme, "\(app.name) has a malformed scheme")
        }
    }

    func testSchemesAreUnique() {
        let schemes = LauncherApp.all.map(\.scheme)

        XCTAssertEqual(Set(schemes).count, schemes.count)
    }

    func testEverySchemeIsDeclaredInInfoPlist() throws {
        let declared = try XCTUnwrap(
            Bundle.main.object(forInfoDictionaryKey: "LSApplicationQueriesSchemes") as? [String]
        )

        for app in LauncherApp.all {
            XCTAssertTrue(declared.contains(app.scheme), "\(app.scheme) missing from Info.plist")
        }
    }
}
