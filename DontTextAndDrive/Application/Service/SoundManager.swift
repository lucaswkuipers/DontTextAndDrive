import UIKit
import AVFAudio

var player: AVAudioPlayer?

final class SoundManager {
    static let shared = SoundManager()
    private let primaryKeySound = SystemSoundID(1123)
    private let deleteKeySound = SystemSoundID(1155)
    private let modifierKeySound = SystemSoundID(1156)

    private init() {}

    func playPrimaryKeySound() {
        play(systemSoundID: primaryKeySound)
        HapticsManager.shared.impactVibration(style: .rigid, at: 1)
    }

    func playModifierKeySound() {
        play(systemSoundID: modifierKeySound)
        HapticsManager.shared.impactVibration(style: .heavy, at: 1)
    }

    func playDeleteKeySound() {
        play(systemSoundID: deleteKeySound)
        HapticsManager.shared.impactVibration(style: .soft, at: 1)
    }

    private func play(systemSoundID soundID: SystemSoundID) {
        DispatchQueue.main.async {
            AudioServicesPlaySystemSound(soundID)
        }
    }
}
