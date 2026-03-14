#if canImport(SwiftUI)
import SwiftUI

public struct RootView: View {
    @EnvironmentObject private var viewModel: AssistantViewModel

    public init() {}

    public var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Assistant", systemImage: "waveform.circle")
                }

            AccountPrivacyView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
        }
        .tint(.indigo)
    }
}

#Preview {
    RootView()
        .environmentObject(AssistantViewModel())
}
#endif
