import UIKit
import AVFAudio

var player: AVAudioPlayer?

final class SoundManager {
    static let shared = SoundManager()
    private let primaryKeySound = SystemSoundID(1123)
    private let modifierKeySound = SystemSoundID(1155)
    private let deleteKeySound = SystemSoundID(1156)

    private init() {}

    func playPrimaryKeySound() {
        play(systemSoundID: primaryKeySound)
    }

    func playModifierKeySound() {
        play(systemSoundID: modifierKeySound)
    }

    func playDeleteKeySound() {
        play(systemSoundID: deleteKeySound)
    }

    private func play(systemSoundID soundID: SystemSoundID) {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            AudioServicesPlaySystemSound(soundID)
        }
    }
}
