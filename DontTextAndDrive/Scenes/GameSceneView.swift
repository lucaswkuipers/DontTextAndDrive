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
        isPlaying = false
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
        isPlaying = true
        scene?.isPaused = false
    }
}
