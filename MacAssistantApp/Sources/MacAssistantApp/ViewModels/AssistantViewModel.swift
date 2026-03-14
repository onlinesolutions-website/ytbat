#if canImport(SwiftUI)
import SwiftUI

@MainActor
public final class AssistantViewModel: ObservableObject {
    @Published public var userPrompt = ""
    @Published public var response = "Hello, I am Mac. I can help you organize daily life, reminders, web tasks, and communication."
    @Published public var features = AssistantFeature.defaults
    @Published public var innovationIdeas: [String] = [
        "Morning Briefing: summarize calendar, weather, and priorities in one voice briefing.",
        "Adaptive Focus Mode: auto-silence distractions while active tasks are running.",
        "Action Memory: remember repeated routines and suggest one-tap automations.",
        "Travel Concierge: track itineraries, check-in reminders, and local maps.",
        "Family Safety Center: shared emergency contacts and location-aware alerts."
    ]
    @Published public var isLoading = false

    private let persona = MacPersona()
    private let voiceService = VoiceService()
    private let apiClient: AssistantAPIClient

    public init(apiClient: AssistantAPIClient = AssistantAPIClient()) {
        self.apiClient = apiClient
    }

    public func submitPrompt() {
        let prompt = userPrompt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !prompt.isEmpty else { return }

        isLoading = true

        Task {
            do {
                let result = try await apiClient.send(prompt: prompt, userId: "local-user")
                response = result.response
            } catch {
                if MacPolicy.shared.isAllowed(topic: prompt) {
                    response = "Understood. I will assist with: \(prompt). I will keep your requests private and focused on approved assistant features."
                } else {
                    response = "I can help with assistant workflows, account settings, or privacy controls. Please rephrase your request within those areas."
                }
            }

            voiceService.speak(response)
            userPrompt = ""
            isLoading = false
        }
    }

    public var personaHeader: String {
        "\(persona.name) • \(persona.voiceDescription)"
    }
}
#endif
