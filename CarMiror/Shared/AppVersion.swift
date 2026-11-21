import Foundation

/// Version shown on screen, so the author can tell which CI build is installed.
struct AppVersion: Equatable {
    let marketing: String
    let build: String

    init(marketing: String, build: String) {
        self.marketing = marketing
        self.build = build
    }

    init(bundle: Bundle) {
        self.init(
            marketing: bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "?",
            build: bundle.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "?"
        )
    }

    var label: String {
        "v\(marketing) (\(build))"
    }
}
