//import CoreGraphics
//import SpriteKit
//
//protocol GameSceneDelegate: AnyObject {}
//
//final class GameScene: SKScene {
//    weak var gameDelegate: GameSceneDelegate?
//    private var horizontalVelocity: CGFloat = 30
//    let motion = MotionManager()
//
//    private let backgroundNode: SKSpriteNode = {
//        let node = SKSpriteNode()
//        node.texture = SKTexture(imageNamed: "background")
//        node.size = node.texture?.size() ?? .zero
//        return node
//    }()
//
//    let treeNode: SKSpriteNode = {
//        let node = SKSpriteNode()
//        node.texture = SKTexture(imageNamed: "tree")
//        node.size = node.texture?.size() ?? .zero
//        return node
//    }()
//
//    override init() {
//        super.init(size: Device.size)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override func didMove(to view: SKView) {
//        super.didMove(to: view)
//
//        addChild(backgroundNode)
//        backgroundNode.position.x = frame.width / 2
//        backgroundNode.position.y = -frame.height / 2
//
//        backgroundNode.addChild(treeNode)
//        treeNode.position.x = backgroundNode.frame.width / 2
//        treeNode.position.y = -0.5
//    }
//
//    override func update(_ currentTime: TimeInterval) {
//        super.update(currentTime)
//
//        guard let rotation = motion.getRotation() else { return }
//        guard let inclination = motion.getInclination() else { return }
//
//        let x = backgroundNode.position.x
////        let y = backgroundNode.position.y
//
////        if x > frame.width * (3/4) && rotation < 0 { return }
////        if x < frame.width * (1/4) && rotation > 0 { return }
//
//        backgroundNode.position.x -= horizontalVelocity * min(rotation, 0.17)
////        backgroundNode.position.y -= horizontalVelocity * min(inclination, 0.17)
//    }
//}
//
//extension GameScene: GameSceneProtocol {}
