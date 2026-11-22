import SwiftUI

struct LauncherView: View {
    @State private var viewModel = LauncherViewModel(availability: SystemAppAvailability())
    @Environment(\.openURL) private var openURL
    @Environment(\.scenePhase) private var scenePhase

    private let version = AppVersion(bundle: .main)
    private let columns = [GridItem(.adaptive(minimum: 150), spacing: 16)]

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.sections.isEmpty {
                    emptyState
                } else {
                    grid
                }
            }
            .navigationTitle("launcher.title")
        }
        .onAppear {
            // The phone sits in a car mount: the screen must not lock while the launcher is open.
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                viewModel.refresh()
            }
        }
    }

    private var grid: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                ForEach(viewModel.sections) { section in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(section.category.titleKey)
                            .font(.title2.bold())
                            .accessibilityAddTraits(.isHeader)

                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(section.apps) { app in
                                LauncherTile(app: app) {
                                    openURL(app.url)
                                }
                            }
                        }
                    }
                }

                versionLabel
            }
            .padding(16)
        }
    }

    private var emptyState: some View {
        VStack {
            ContentUnavailableView(
                "launcher.empty.title",
                systemImage: "apps.iphone",
                description: Text("launcher.empty.description")
            )
            versionLabel
        }
    }

    private var versionLabel: some View {
        Text(version.label)
            .font(.footnote.monospacedDigit())
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    LauncherView()
}
