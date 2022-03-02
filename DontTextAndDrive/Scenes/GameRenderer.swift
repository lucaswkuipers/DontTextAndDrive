import SceneKit

final class GameRenderer: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    let motion = MotionManager()

    private var lastTime = 0.0

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if lastTime == 0.0 {
            lastTime = time
            return
        }

        let timePassed = time - lastTime
        print("---")
        print("Time passed: \(timePassed)")
        print("Time: \(time)")
        print("Last time: \(lastTime)")
        print("---")

        lastTime = time


        let dxFactor: Float = 60 * 4
        let car = scene?.rootNode.childNode(withName: "car", recursively: true)
        let dx = motion.getRotation() * Float(timePassed) * dxFactor
        print("Car dx: \(dx)")
        let force = SCNVector3(x: dx, y: 0, z: 0)
        car?.physicsBody?.applyForce(force, at: SCNVector3(x: 0, y: 0, z: 0), asImpulse: false)

        guard let pos = car?.presentation.worldPosition.x else { return }

        let bounds: Float = 4.5
        print("Car x position: \(pos)")

        car?.position.x = pos.clamped(to: bounds)
    }
}
