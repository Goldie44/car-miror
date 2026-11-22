import Observation

struct LauncherSection: Identifiable, Equatable {
    let category: LauncherCategory
    let apps: [LauncherApp]

    var id: LauncherCategory { category }
}

@MainActor
@Observable
final class LauncherViewModel {
    private(set) var sections: [LauncherSection] = []

    private let catalog: [LauncherApp]
    private let availability: AppAvailabilityChecking

    init(catalog: [LauncherApp] = LauncherApp.all, availability: AppAvailabilityChecking) {
        self.catalog = catalog
        self.availability = availability
        refresh()
    }

    /// Called again when the app comes back to the foreground, since the author
    /// may have installed or removed an app in the meantime.
    func refresh() {
        let installed = catalog.filter { availability.isInstalled($0) }
        sections = LauncherCategory.allCases.compactMap { category in
            let apps = installed.filter { $0.category == category }
            return apps.isEmpty ? nil : LauncherSection(category: category, apps: apps)
        }
    }
}
