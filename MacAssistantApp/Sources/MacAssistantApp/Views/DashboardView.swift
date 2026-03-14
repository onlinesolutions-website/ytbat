#if canImport(SwiftUI)
import SwiftUI

public struct DashboardView: View {
    @EnvironmentObject private var viewModel: AssistantViewModel

    public init() {}

    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(viewModel.personaHeader)
                        .font(.headline)
                    Text(viewModel.response)
                        .font(.body)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ask Mac")
                            .font(.headline)
                        HStack {
                            TextField("e.g., Set a reminder for 7PM", text: $viewModel.userPrompt)
                                .textFieldStyle(.roundedBorder)
                            Button("Send") {
                                viewModel.submitPrompt()
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(viewModel.isLoading)
                        }

                        if viewModel.isLoading {
                            ProgressView("Mac is preparing your response...")
                                .font(.footnote)
                        }

                        Text("Tip: this client can connect to a Vercel backend endpoint at /api/mac.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Text("Core Features")
                        .font(.title3.weight(.semibold))

                    ForEach(viewModel.features) { feature in
                        FeatureCard(feature: feature)
                    }

                    Text("Innovation Ideas")
                        .font(.title3.weight(.semibold))

                    ForEach(viewModel.innovationIdeas, id: \.self) { idea in
                        Label(idea, systemImage: "sparkles")
                            .font(.subheadline)
                            .padding(.vertical, 4)
                    }
                }
                .padding()
            }
            .navigationTitle("Mac Assistant")
        }
    }
}
#endif
