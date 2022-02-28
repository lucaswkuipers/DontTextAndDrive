import SceneKit

final class GameRenderer: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    let motion = MotionManager()

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        print(scene?.rootNode.description)

        let car = scene?.rootNode.childNode(withName: "box", recursively: true)
        let dx = motion.getRotation()  + 1 * 0.5
        let dz = motion.getInclination() + 1 * 0.5
        let force = SCNVector3(x: dx, y: 0, z: -dz)
        car?.physicsBody?.applyForce(force, at: SCNVector3(x: 0, y: 0, z: 0), asImpulse: false)
        print(car.debugDescription)

        print("Heeeee working!")
    }
}
