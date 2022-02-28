import SceneKit
final class GameNode: SCNNode {
    override init() {
        super.init()

//        // camera
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
//        addChildNode(cameraNode)

//        // light
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light!.type = .ambient
//        ambientLightNode.light!.color = UIColor.darkGray
//        addChildNode(ambientLightNode)

//        // ball
//        let shape = SCNSphere(radius: 1)
//        let clearMaterial = SCNMaterial()
//        clearMaterial.diffuse.contents = UIColor(white: 0.9, alpha: 0.5)
//        clearMaterial.locksAmbientWithDiffuse = true
//        shape.materials = [clearMaterial]
//        let node = SCNNode(geometry: shape)
//        let physicsShape = SCNPhysicsShape(geometry: shape, options: nil)
//        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: physicsShape)
//        node.physicsBody = physicsBody
//        node.position = SCNVector3(10, 10, 10)
//        addChildNode(node)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
