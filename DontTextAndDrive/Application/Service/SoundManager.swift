import UIKit
import AVFAudio

var player: AVAudioPlayer?

final class SoundManager {
    static let shared = SoundManager()

    private init() {}

    func playKeySound() {
        DispatchQueue.main.async {
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        }
    }
}
