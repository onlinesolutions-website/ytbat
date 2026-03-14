import Foundation

public struct AssistantFeature: Identifiable, Hashable {
    public let id = UUID()
    public let title: String
    public let subtitle: String
    public let systemImage: String
}

public extension AssistantFeature {
    static let defaults: [AssistantFeature] = [
        .init(title: "Smart Lists", subtitle: "Create and manage task lists with voice.", systemImage: "checklist"),
        .init(title: "Push Reminders", subtitle: "Schedule reminders and receive local push alerts.", systemImage: "bell.badge"),
        .init(title: "Web Search + Summary", subtitle: "Open pages, read them, and ask Mac for concise summaries.", systemImage: "safari"),
        .init(title: "Website Builder", subtitle: "Generate starter websites and edit pages with guided prompts.", systemImage: "globe"),
        .init(title: "Email + Text", subtitle: "Compose, draft, and send messages with account-level consent.", systemImage: "envelope"),
        .init(title: "Device Automations", subtitle: "Run permission-based automations for daily workflows.", systemImage: "gearshape.2")
    ]
}
