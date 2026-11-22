import SwiftUI

struct LauncherTile: View {
    let app: LauncherApp
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: app.category.symbol)
                    .font(.system(size: 40))
                    .accessibilityHidden(true)

                Text(verbatim: app.name)
                    .font(.title3.bold())
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, minHeight: 120)
            .padding(12)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 20))
        .tint(app.category.tint)
    }
}
