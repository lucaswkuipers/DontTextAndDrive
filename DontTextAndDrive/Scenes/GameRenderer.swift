import SceneKit

final class GameRenderer: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    let motion = MotionManager()

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let car = scene?.rootNode.childNode(withName: "car", recursively: true)
        let dx = (motion.getRotation())
        print(dx)
        let force = SCNVector3(x: dx, y: 0, z: 0)
        car?.physicsBody?.applyForce(force, at: SCNVector3(x: 0, y: 0, z: 0), asImpulse: false)
    }
}
