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
    private let carWidth = 1.76784 // m
    private let leftRoadBoundary = -3.7 // m
    private let rightRoadBoundary = 3.7 // m
    private let carMass = 1885.0 // kg
    private let carTurningForce: Double = 5
    private let groundCarFrictionCoefficient = 0.7
    private let gravityAcceleration = 9.8 // m/s^2

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
//        let targetVelocity = maximumCarHorizontalVelocity * Float(carTurnPercentage)



        // Velocity
        carHorizontalVelocity += carTurnPercentage * 0.1
        carHorizontalVelocity *= 0.96

        carHorizontalVelocity.clamp(to: maximumCarHorizontalVelocity)



        // Position
        let bounds: Float = Float(abs(rightRoadBoundary - carWidth / 2))
        carHorizontalPosition += carHorizontalVelocity * Float(timePassed)
        carHorizontalPosition.clamp(to: bounds)
        carNode.worldPosition.x = carHorizontalPosition

        print("---")
        print("Phone Rotation Percetange: \(motion.getRotationPercentage())")
        print("Horizontal velocity: \(carHorizontalVelocity)")
        print("Horizontal position: \(carNode.worldPosition.x)")
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
