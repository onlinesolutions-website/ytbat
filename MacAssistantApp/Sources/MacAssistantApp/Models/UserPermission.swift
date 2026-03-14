import Foundation

public enum UserPermission: String, CaseIterable, Identifiable {
    case contacts
    case reminders
    case calendar
    case microphone
    case speechRecognition
    case notifications
    case location
    case photos

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .contacts: "Contacts"
        case .reminders: "Reminders"
        case .calendar: "Calendar"
        case .microphone: "Microphone"
        case .speechRecognition: "Speech Recognition"
        case .notifications: "Notifications"
        case .location: "Location"
        case .photos: "Photos"
        }
    }
}
