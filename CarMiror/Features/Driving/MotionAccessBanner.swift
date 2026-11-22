import SwiftUI

/// Shown when driving detection cannot run, so the author knows video is no longer protected.
struct MotionAccessBanner: View {
    let access: MotionAccess
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("driving.access.title", systemImage: "exclamationmark.triangle.fill")
                .font(.headline)

            Text(descriptionKey)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if access == .denied, let settings = URL(string: UIApplication.openSettingsURLString) {
                Button("driving.access.openSettings") {
                    openURL(settings)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.orange.opacity(0.15), in: RoundedRectangle(cornerRadius: 16))
    }

    private var descriptionKey: LocalizedStringKey {
        access == .unavailable ? "driving.access.unavailable" : "driving.access.denied"
    }
}
