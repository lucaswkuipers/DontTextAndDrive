import AVFAudio

final class SoundManager {
    static let shared = SoundManager()

    enum SystemSound: Int {
        case primaryKeyPress = 1123
        case deleteKeyPress = 1155
        case modifierKeyPress = 1156

        var identifier: SystemSoundID {
            return SystemSoundID(rawValue)
        }

        var hapticPattern: HapticsManager.HapticPattern {
            switch self {
            case .primaryKeyPress:
                return .primaryKeyPress
            case .deleteKeyPress:
                return .deleteKeyPress
            case .modifierKeyPress:
                return .modifierKeyPress
            }
        }
    }

    private init() {}

    func play(systemSound sound: SystemSound) {
        HapticsManager.shared.play(hapticPattern: sound.hapticPattern)
        DispatchQueue.main.async {
            AudioServicesPlaySystemSound(sound.identifier)
        }
    }
}
