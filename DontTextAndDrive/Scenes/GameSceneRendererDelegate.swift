import SceneKit

final class GameSceneRendererDelegate: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    private let motion = MotionManager()
    private var lastTime = 0.0

    private var roadMarks: [SCNNode] = []

    private var carNodes: [SCNNode] = []
    private var carNode: SCNNode?
    private var lastSpawnedCarTime = 0.0

    private var playerNode: SCNNode?
    private var playerFrontVelocity = 8.3 * 2 // m/s
    private var playerHorizontalPosition: Float = 0 // m/s
    private var playerHorizontalVelocity: Float = 0 // m/s
    private let maximumPlayerHorizontalVelocity: Float = 2.5 // m/s
    private let playerWidth: Float = 1.76784 // m
    private let roadBounds: Float = 3.7 // m
    private let friction: Float = 0.96
    private let turnVelocity: Float = 0.1

    // Road mark
    private var lastSpawnedRoadMarkTime = 0.0

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // First time
        if lastTime == 0 && roadMarks.count <= 0 {
            // Connect road marks
            for i in -1...11 {
                if let roadMarkNode = scene?.rootNode.childNode(withName: "road_mark_\(i)", recursively: true) {
                    roadMarks.append(roadMarkNode)
                }
            }
        }

//        if lastTime == 0 && carNode == nil {
//            let carScene = SCNScene(named: "car.dae")
//            carNode = carScene?.rootNode.childNode(withName: "car", recursively: false)
////            print(carScene)
////            print(carNode)
//            if let carNode = carNode {
//                scene?.rootNode.addChildNode(carNode)
//                carNode.position.y = 0
//                carNode.position.x = -2.5
//                carNode.position.z = -55
//            }
//        }

        // Time Update
        let timePassed = getTimePassed(from: lastTime, to: time)
        updateTime(to: time)
        if timePassed >= 0.1 { return }

        // Game loop
        moveCarHorizontally(timePassed: timePassed)

        // Spawn cars
        if time - lastSpawnedCarTime + Double.random(in: -2...1) > 3 && carNodes.count < 6 {
            let carScene = SCNScene(named: "car.dae")
            carNode = carScene?.rootNode.childNode(withName: "car", recursively: false)
            if let carNode = carNode {
                scene?.rootNode.addChildNode(carNode)
                carNode.position.y = 0
                carNode.position.x = -2.5
                carNode.position.z = -500
                carNodes.append(carNode)
            }
            lastSpawnedCarTime = time
        }

        // Move road marks
        for roadMark in roadMarks {
            roadMark.worldPosition.z += Float(timePassed * playerFrontVelocity)
        }

        // Move  cars
        for carNode in carNodes {
            carNode.worldPosition.z += Float(timePassed * (playerFrontVelocity * 3))

            if carNode.worldPosition.z  > 5 {
                carNode.worldPosition.z = -505
                carNode.worldPosition.x = Float(Double.random(in: (-2.5...2.5)))
            }
        }

        // Loop road marks
        for roadMark in roadMarks {
            if roadMark.worldPosition.z > 5 {
                roadMark.worldPosition.z = -55
            }
        }
    }

    private func getTimePassed(from previousTime: TimeInterval, to currentTime: TimeInterval) -> Double {
        guard previousTime > 0 else { return 0 }
        let timePassed = currentTime - previousTime
        return timePassed
    }

    private func updateTime(to currentTime: TimeInterval) {
        lastTime = currentTime
    }

    private func moveCarHorizontally(timePassed: TimeInterval) {
        if playerNode == nil {
            playerNode = scene?.rootNode.childNode(withName: "camera", recursively: false)
        }

        guard let carNode = playerNode else { return }
        let carTurnPercentage = Float(motion.getRotationPercentage())

        // Velocity
        playerHorizontalVelocity += carTurnPercentage * turnVelocity
        playerHorizontalVelocity *= friction
        playerHorizontalVelocity.clamp(to: maximumPlayerHorizontalVelocity)

        // Position
        let bounds = abs(roadBounds - playerWidth / 2)
        playerHorizontalPosition += playerHorizontalVelocity * Float(timePassed)
        playerHorizontalPosition.clamp(to: bounds)
        carNode.worldPosition.x = playerHorizontalPosition

        log("---")
        log("Phone Rotation Percentange: \(motion.getRotationPercentage())")
        log("Horizontal velocity: \(playerHorizontalVelocity)")
        log("Horizontal position: \(carNode.worldPosition.x)")
    }

    // MARK: - DEBUG
    private func logTime(previousTime: TimeInterval, currentTime: TimeInterval, timePassed: TimeInterval) {
        log("---")
        log("Last time: \(previousTime)")
        log("Current time: \(currentTime)")
        log("Time passed: \(timePassed)")
        log("---")
    }
}
