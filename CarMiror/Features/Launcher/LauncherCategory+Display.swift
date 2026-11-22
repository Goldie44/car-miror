import SwiftUI

extension LauncherCategory {
    var titleKey: LocalizedStringKey {
        switch self {
        case .video: "launcher.category.video"
        case .music: "launcher.category.music"
        case .navigation: "launcher.category.navigation"
        }
    }

    var symbol: String {
        switch self {
        case .video: "play.rectangle.fill"
        case .music: "music.note"
        case .navigation: "map.fill"
        }
    }

    /// Dark enough for white bold text at tile size (WCAG large text, 3:1).
    var tint: Color {
        switch self {
        case .video: .red
        case .music: .indigo
        case .navigation: .blue
        }
    }
}
