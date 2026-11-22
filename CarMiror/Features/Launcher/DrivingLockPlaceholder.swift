import SwiftUI

/// Takes the place of a section hidden while driving, so it does not vanish without explanation.
struct DrivingLockPlaceholder: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "car.side.fill")
                .font(.system(size: 36))
                .accessibilityHidden(true)

            Text("launcher.drivingLock.title")
                .font(.headline)

            Text("launcher.drivingLock.description")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, minHeight: 120)
        .padding(16)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 20))
        .accessibilityElement(children: .combine)
    }
}
