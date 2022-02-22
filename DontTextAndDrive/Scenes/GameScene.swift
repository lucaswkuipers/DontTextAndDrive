import CoreGraphics
import SpriteKit

protocol GameSceneDelegate: AnyObject {}

final class GameScene: SKScene {
    weak var gameDelegate: GameSceneDelegate?

    override init() {
        super.init(size: Device.size)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension GameScene: GameSceneProtocol {}
