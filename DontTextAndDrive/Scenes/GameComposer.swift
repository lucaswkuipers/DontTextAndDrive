import SceneKit

enum GameComposer {
    static func makeScene() -> UIViewController {
        guard let scene = SCNScene(named: "GameScene.scn") else { fatalError() }
        let rootNode = GameNode()
        let renderer = GameRenderer()
        let view = GameView()
        let viewController = GenericViewController()

        renderer.scene = scene
        scene.rootNode.addChildNode(rootNode)
        view.scene = scene
        view.gameDelegate = renderer
        viewController.view = view

        return viewController
    }
}
