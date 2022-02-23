import CoreGraphics
import SpriteKit

protocol GameSceneDelegate: AnyObject {}

final class GameScene: SKScene {
    weak var gameDelegate: GameSceneDelegate?
    private var horizontalVelocity: CGFloat = 50
    let motion = MotionManager()

    private let backgroundNode: SKSpriteNode = {
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed: "background")
        node.size = node.texture?.size() ?? .zero
        return node
    }()

    override init() {
        super.init(size: Device.size)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        addChild(backgroundNode)
        backgroundNode.position.x = frame.width / 2
        backgroundNode.position.y = -frame.height / 2
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)

        guard let rotation = motion.getRotation() else { return }

        let x = backgroundNode.position.x

        if x > frame.width * (3/4) && rotation < 0 { return }
        if x < frame.width * (1/4) && rotation > 0 { return }

        backgroundNode.position.x -= horizontalVelocity * min(rotation, 0.17)
    }
}

extension GameScene: GameSceneProtocol {}
