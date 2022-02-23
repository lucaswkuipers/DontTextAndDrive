import CoreGraphics
import SpriteKit

protocol GameSceneDelegate: AnyObject {}

final class GameScene: SKScene {
    weak var gameDelegate: GameSceneDelegate?
    private var horizontalVelocity: CGFloat = 1

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

        backgroundNode.position.x += horizontalVelocity

        if backgroundNode.position.x.isBetween(frame.width * (1/4), and: frame.width * (3/4)) { return }

        horizontalVelocity *= -1
    }
}

extension GameScene: GameSceneProtocol {}
