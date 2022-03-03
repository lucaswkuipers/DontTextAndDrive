import SceneKit

protocol GameSceneViewProtocol: SCNView {
    func unpauseGame()
}

final class GameAdapter {
    var sceneView: GameSceneViewProtocol?
}

extension GameAdapter: GenericViewControllerDelegate {
    func viewDidAppear() {
        sceneView?.unpauseGame()
    }
}
