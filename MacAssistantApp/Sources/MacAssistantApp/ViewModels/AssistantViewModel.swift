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

    private let persona = MacPersona()
    private let voiceService = VoiceService()

    public init() {}

    public func submitPrompt() {
        guard !userPrompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        if MacPolicy.shared.isAllowed(topic: userPrompt) {
            response = "Understood. I will assist with: \(userPrompt). I will keep your requests private and focused on approved assistant features."
        } else {
            response = "I can help with assistant workflows, account settings, or privacy controls. Please rephrase your request within those areas."
        }

        voiceService.speak(response)
        userPrompt = ""
    }

    public var personaHeader: String {
        "\(persona.name) • \(persona.voiceDescription)"
    }
}
#endif
