import UIKit

/// Tells whether an app is installed. A protocol so tests can use a fake phone.
@MainActor
protocol AppAvailabilityChecking {
    func isInstalled(_ app: LauncherApp) -> Bool
}

struct SystemAppAvailability: AppAvailabilityChecking {
    func isInstalled(_ app: LauncherApp) -> Bool {
        UIApplication.shared.canOpenURL(app.url)
    }
}
