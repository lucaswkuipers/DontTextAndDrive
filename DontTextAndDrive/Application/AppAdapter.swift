import SceneKit

final class AppAdapter {
    private init() {}

    static let shared = AppAdapter()
    var sceneView: SCNView?

    func willApplicationBecomeInactive() {
        print("💤 App  will become inactive")
        sceneView?.scene?.isPaused = true
        sceneView?.isPlaying = false
    }

    func didApplicationBecomeActive() {
        print("☕️ App did become active")
        sceneView?.scene?.isPaused = false
        sceneView?.isPlaying = true
    }

}
