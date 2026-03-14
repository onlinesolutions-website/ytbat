import Foundation

public struct MacPolicy {
    public static let shared = MacPolicy()

    private init() {}

    public func isAllowed(topic: String) -> Bool {
        let allowedTopics = [
            "task",
            "list",
            "reminder",
            "web",
            "website",
            "summary",
            "email",
            "text",
            "account",
            "privacy",
            "permission",
            "automation"
        ]

        return allowedTopics.contains { topic.localizedCaseInsensitiveContains($0) }
    }
}
