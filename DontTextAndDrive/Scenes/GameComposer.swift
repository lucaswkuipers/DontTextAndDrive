import SceneKit

enum GameComposer {
    static func makeScene() -> UIViewController? {
        guard let scene = SCNScene(named: "GameScene.scn") else { return nil }
        scene.isPaused = true
        let viewController = GenericViewController()
        let view = GameView()
        let sceneView = GameSceneView()
        let sceneRendererDelegate = GameSceneRendererDelegate()
        let adapter = GameAdapter()

        viewController.delegate = adapter
        adapter.sceneView = sceneView
        sceneView.scene = scene
        sceneRendererDelegate.scene = scene
        sceneView.renderer = sceneRendererDelegate
        view.sceneView = sceneView
        viewController.view = view

        return viewController
    }
}
