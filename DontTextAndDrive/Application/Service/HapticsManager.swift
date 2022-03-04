import UIKit

final class HapticsManager {
    static let shared = HapticsManager()

    enum HapticPattern {
        case primaryKeyPress
        case deleteKeyPress
        case modifierKeyPress

        var style: UIImpactFeedbackGenerator.FeedbackStyle {
            switch self {
            case .primaryKeyPress:
                return .rigid
            case .modifierKeyPress:
                return .heavy
            case .deleteKeyPress:
                return .soft
            }
        }

        var intensity: CGFloat {
            return 1
        }
    }

    private init() {}

    func play(hapticPattern haptic: HapticPattern) {
        DispatchQueue.main.async {
            let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: haptic.style)
            impactFeedbackGenerator.prepare()
            impactFeedbackGenerator.impactOccurred(intensity: haptic.intensity)
        }
    }
}
