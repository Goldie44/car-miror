import SwiftUI

struct HomeView: View {
    private let version = AppVersion(bundle: .main)

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "car.fill")
                .font(.system(size: 64))
                .foregroundStyle(.tint)
                .accessibilityHidden(true)

            Text("home.title")
                .font(.largeTitle.bold())

            Text("home.toolchainOk")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Text(version.label)
                .font(.footnote.monospacedDigit())
                .foregroundStyle(.secondary)
        }
        .padding(24)
    }
}

#Preview {
    HomeView()
}
