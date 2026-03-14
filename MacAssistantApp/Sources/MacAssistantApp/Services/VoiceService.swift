import Foundation

#if canImport(AVFoundation)
import AVFoundation
#endif

public final class VoiceService {
    #if canImport(AVFoundation)
    private let synthesizer = AVSpeechSynthesizer()
    #endif

    public init() {}

    public func speak(_ text: String) {
        #if canImport(AVFoundation)
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.47
        utterance.pitchMultiplier = 0.92

        if let voice = AVSpeechSynthesisVoice.speechVoices().first(where: { $0.gender == .male && $0.language.hasPrefix("en") }) {
            utterance.voice = voice
        }

        synthesizer.speak(utterance)
        #else
        _ = text
        #endif
    }
}
