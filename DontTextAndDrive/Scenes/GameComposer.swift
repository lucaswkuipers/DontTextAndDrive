import SceneKit

enum GameComposer {
    static func makeScene() -> UIViewController {
        let viewController = GenericViewController()
        let view = GameView()
        let sceneView = GameSceneView()
        guard let scene = SCNScene(named: "GameScene.scn") else { return UIViewController() }
        let sceneRendererDelegate = GameSceneRendererDelegate()

        sceneView.scene = scene
        sceneRendererDelegate.scene = scene
        sceneView.renderer = sceneRendererDelegate
        view.sceneView = sceneView
        viewController.view = view

        return viewController
    }
}
