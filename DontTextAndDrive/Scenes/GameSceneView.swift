import SceneKit

final class GameSceneView: SCNView {
    var renderer: SCNSceneRendererDelegate? {
        didSet {
            delegate = renderer
        }
    }

    init() {
        super.init(frame: Device.bounds, options: nil)
        setupPreferences()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupPreferences() {
        preferredFramesPerSecond = 120

        #if DEBUG
        showsStatistics = true
        #endif
    }
}

extension GameSceneView: GameSceneViewProtocol {
    func unpauseGame() {
        guard let carNode = scene?.rootNode.childNode(withName: "camera", recursively: false) else { return }
        carNode.worldPosition.x = 0
        isPlaying = true
        scene?.isPaused = false
    }
}
