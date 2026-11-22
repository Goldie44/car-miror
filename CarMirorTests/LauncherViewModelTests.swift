import XCTest
@testable import CarMiror

@MainActor
private final class FakeAvailability: AppAvailabilityChecking {
    var installedSchemes: Set<String>

    init(installedSchemes: Set<String>) {
        self.installedSchemes = installedSchemes
    }

    func isInstalled(_ app: LauncherApp) -> Bool {
        installedSchemes.contains(app.scheme)
    }
}

final class LauncherViewModelTests: XCTestCase {
    private let netflix = LauncherApp(scheme: "nflx", name: "Netflix", category: .video)
    private let youtube = LauncherApp(scheme: "youtube", name: "YouTube", category: .video)
    private let spotify = LauncherApp(scheme: "spotify", name: "Spotify", category: .music)
    private let waze = LauncherApp(scheme: "waze", name: "Waze", category: .navigation)

    private var catalog: [LauncherApp] { [netflix, youtube, spotify, waze] }

    @MainActor
    func testShowsOnlyInstalledAppsGroupedInCategoryOrder() {
        let availability = FakeAvailability(installedSchemes: ["waze", "nflx", "youtube"])

        let viewModel = LauncherViewModel(catalog: catalog, availability: availability)

        XCTAssertEqual(viewModel.sections, [
            LauncherSection(category: .video, apps: [netflix, youtube]),
            LauncherSection(category: .navigation, apps: [waze]),
        ])
    }

    @MainActor
    func testHasNoSectionsWhenNothingIsInstalled() {
        let viewModel = LauncherViewModel(catalog: catalog, availability: FakeAvailability(installedSchemes: []))

        XCTAssertTrue(viewModel.sections.isEmpty)
    }

    @MainActor
    func testRefreshPicksUpAnAppInstalledLater() {
        let availability = FakeAvailability(installedSchemes: [])
        let viewModel = LauncherViewModel(catalog: catalog, availability: availability)

        availability.installedSchemes = ["spotify"]
        viewModel.refresh()

        XCTAssertEqual(viewModel.sections, [LauncherSection(category: .music, apps: [spotify])])
    }
}
