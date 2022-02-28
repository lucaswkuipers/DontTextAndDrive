import SceneKit

final class GameView: SCNView {
    var gameDelegate: SCNSceneRendererDelegate? {
        didSet {
            delegate = gameDelegate
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
        allowsCameraControl = true
        showsStatistics = true
        #endif
    }
}
