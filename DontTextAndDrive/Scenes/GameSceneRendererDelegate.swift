import SceneKit

final class GameSceneRendererDelegate: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    private let motion = MotionManager()
    private var lastTime = 0.0

    private var carNode: SCNNode?
    private var carFrontVelocity: Float = 0.2 * 60 // m/s
    private var carHorizontalPosition: Float = 0 // m/s
    private var carHorizontalVelocity: Float = 0 // m/s
    private let maximumCarHorizontalVelocity: Float = 2.5 // m/s
    private let carWidth: Float = 1.76784 // m
    private let roadBounds: Float = 3.7 // m
    private let friction: Float = 0.96
    private let turnVelocity: Float = 0.1

    // Road mark
    private var lastSpawnedRoadMarkTime = 0.0

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Time Update
        let timePassed = getTimePassed(from: lastTime, to: time)
        updateTime(to: time)

        // Game loop
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
        if carNode == nil {
            carNode = scene?.rootNode.childNode(withName: "camera", recursively: false)
        }

        guard let carNode = carNode else { return }
        let carTurnPercentage = Float(motion.getRotationPercentage())

        // Velocity
        carHorizontalVelocity += carTurnPercentage * turnVelocity
        carHorizontalVelocity *= friction
        carHorizontalVelocity.clamp(to: maximumCarHorizontalVelocity)

        // Position
        let bounds = abs(roadBounds - carWidth / 2)
        carHorizontalPosition += carHorizontalVelocity * Float(timePassed)
        carHorizontalPosition.clamp(to: bounds)
        carNode.worldPosition.x = carHorizontalPosition

        log("---")
        log("Phone Rotation Percentange: \(motion.getRotationPercentage())")
        log("Horizontal velocity: \(carHorizontalVelocity)")
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
