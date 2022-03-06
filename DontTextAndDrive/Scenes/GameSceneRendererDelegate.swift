import SceneKit

final class GameSceneRendererDelegate: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    private let motion = MotionManager()
    private var lastTime = 0.0

    private var roadMarks: [SCNNode] = []
    private var carNodes: [SCNNode] = []
    private var lastSpawnedCarTime = 0.0

    private var playerNode: SCNNode?
    private var playerFrontVelocity = 8.3 * 2 // m/s
    private var playerHorizontalPosition: Float = 0 // m/s
    private var playerHorizontalVelocity: Float = 0 // m/s
    private let maximumPlayerHorizontalVelocity: Float = 2.5 // m/s
    private let playerWidth: Float = 1.76784 // m
    private let roadBounds: Float = 3.7 // m
    private let friction: Float = 0.96
    private let turnVelocity: Float = 0.2

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        connectRoadMarksIfFirstTime()

        // Time Update
        let timePassed = getTimePassed(from: lastTime, to: time)
        updateTime(to: time)
        if timePassed >= 0.1 { return }

        // Game loop
        spawnCars(currentTime: time)
        moveCars(timePassed: timePassed)
        moveRoadMarks(timePassed: timePassed)
        moveCarHorizontally(timePassed: timePassed)
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

    private func spawnCars(currentTime: TimeInterval) {
        let timePassed = currentTime - lastSpawnedCarTime
        let randomVariation = Double.random(in: -3...3)
        let spawningDelta = 8.5
        let maxCarCount = 6
        guard timePassed > spawningDelta + randomVariation,
              carNodes.count < maxCarCount else { return }

        let carScene = SCNScene(named: "car.dae")
        guard let carNode = carScene?.rootNode.childNode(withName: "car", recursively: false) else { return }
        scene?.rootNode.addChildNode(carNode)
        carNode.position.y = 0
        carNode.position.x = -2.5
        carNode.position.z = -500
        carNodes.append(carNode)
        lastSpawnedCarTime = currentTime
    }

    private func moveCars(timePassed: TimeInterval) {
        for carNode in carNodes {
            carNode.worldPosition.z += Float(timePassed * (playerFrontVelocity * 3))

            if carNode.worldPosition.z  > 5 {
                carNode.worldPosition.z = -505
                carNode.worldPosition.x = Float(Double.random(in: (-2.5...2.5)))
            }
        }
    }

    private func moveRoadMarks(timePassed: TimeInterval) {
        for roadMark in roadMarks {
            roadMark.worldPosition.z += Float(timePassed * playerFrontVelocity)

            if roadMark.worldPosition.z > 5 {
                roadMark.worldPosition.z = -55
            }
        }
    }

    private func connectRoadMarksIfFirstTime() {
        guard lastTime == 0 && roadMarks.count <= 0 else { return }
        for i in -1...11 {
            if let roadMarkNode = scene?.rootNode.childNode(withName: "road_mark_\(i)", recursively: true) {
                roadMarks.append(roadMarkNode)
            }
        }
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
