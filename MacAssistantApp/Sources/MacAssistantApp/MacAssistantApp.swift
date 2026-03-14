#if canImport(SwiftUI)
import SwiftUI

@main
public struct MacAssistantApp: App {
    @StateObject private var viewModel = AssistantViewModel()

    public init() {}

    public var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewModel)
        }
    }
}
#endif
