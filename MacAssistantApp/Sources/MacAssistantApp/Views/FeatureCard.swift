#if canImport(SwiftUI)
import SwiftUI

public struct FeatureCard: View {
    let feature: AssistantFeature

    public init(feature: AssistantFeature) {
        self.feature = feature
    }

    public var body: some View {
        HStack(spacing: 14) {
            Image(systemName: feature.systemImage)
                .font(.title2)
                .frame(width: 34)
                .foregroundStyle(.indigo)

            VStack(alignment: .leading, spacing: 6) {
                Text(feature.title)
                    .font(.headline)
                Text(feature.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
#endif
