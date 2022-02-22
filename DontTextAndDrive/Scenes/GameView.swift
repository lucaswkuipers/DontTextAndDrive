import SpriteKit

protocol GameViewDelegate: AnyObject {}

final class GameView: SKView {
    weak var gameDelegate: GameViewDelegate?
    private var currentText = ""

    var gameScene: GameSceneProtocol? {
        didSet {
            presentScene()
        }
    }

    init() {
        super.init(frame: Device.bounds)
        setupPreferences()
        becomeFirstResponder()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func presentScene() {
        presentScene(gameScene)
    }

    private func setupPreferences() {
        preferredFramesPerSecond = 120

        #if DEBUG
        showsDrawCount = true
        ignoresSiblingOrder = true
        showsFPS = true
        showsNodeCount = true
        showsFields = true
        showsPhysics = true
        showsQuadCount = true
        #endif
    }

    override var canBecomeFirstResponder: Bool { return true }
    override var canResignFirstResponder: Bool { return false }
}

extension GameView: GameViewProtocol {}

extension GameView: UIKeyInput {
    var hasText: Bool {
        return !currentText.isEmpty
    }

    func insertText(_ text: String) {
        currentText += text
        print(currentText)
    }

    func deleteBackward() {
        print("So...?")
        if hasText {
            currentText.removeLast()
            print(currentText)
        }
    }
}
