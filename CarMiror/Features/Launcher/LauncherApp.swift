import Foundation

enum LauncherCategory: String, CaseIterable {
    case video
    case music
    case navigation

    /// Watching video while driving is illegal in France; music and navigation stay usable.
    var isHiddenWhileDriving: Bool {
        self == .video
    }
}

/// An app Car Miror can open through its URL scheme.
struct LauncherApp: Identifiable, Hashable {
    let scheme: String
    let name: String
    let category: LauncherCategory

    var id: String { scheme }

    var url: URL {
        // Schemes are constants checked by LauncherAppTests, so this never fails at runtime.
        URL(string: "\(scheme)://")!
    }
}

extension LauncherApp {
    /// Every scheme here must also be listed under LSApplicationQueriesSchemes in Info.plist,
    /// otherwise iOS always answers "not installed".
    static let all: [LauncherApp] = [
        LauncherApp(scheme: "nflx", name: "Netflix", category: .video),
        LauncherApp(scheme: "youtube", name: "YouTube", category: .video),
        LauncherApp(scheme: "disneyplus", name: "Disney+", category: .video),
        LauncherApp(scheme: "aiv", name: "Prime Video", category: .video),
        LauncherApp(scheme: "twitch", name: "Twitch", category: .video),
        LauncherApp(scheme: "spotify", name: "Spotify", category: .music),
        LauncherApp(scheme: "deezer", name: "Deezer", category: .music),
        LauncherApp(scheme: "music", name: "Apple Music", category: .music),
        LauncherApp(scheme: "waze", name: "Waze", category: .navigation),
        LauncherApp(scheme: "comgooglemaps", name: "Google Maps", category: .navigation),
    ]
}
