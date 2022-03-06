import SceneKit

final class GameSceneRendererDelegate: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    private let motion = MotionManager()
    private var lastTime = 0.0

    private var carNode: SCNNode?
    private var carFrontVelocity: Float = 0.2 * 60 // m/s
    private var carHorizontalPosition: Float = 0 // m/s
    private var carHorizontalVelocity: Float = 0 // m/s
    private let maximumCarHorizontalVelocity: Float = 3 // m/s
    private let carWidth = 1.76784 // m
    private let leftRoadBoundary = -3.7 // m
    private let rightRoadBoundary = 3.7 // m
    private let carMass = 1885.0 // kg
    private let carTurningForce = 1885.0 // kg * m / s^2
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

        // Acceleration
        let carTurnPercentage = motion.getRotationPercentage()
        let carHorizontalAcceleration = (carTurningForce * carTurnPercentage) / carMass

        // Velocity
        carHorizontalVelocity += Float(carHorizontalAcceleration)
        carHorizontalVelocity.clamp(to: maximumCarHorizontalVelocity)
        // Friction

        if abs(carTurnPercentage) < 0.01 {
            carHorizontalVelocity.decrease(at: 1 - Float((groundCarFrictionCoefficient * timePassed)), roundingAt: 0.00001)
        }

        // Position
        let bounds: Float = Float(abs(rightRoadBoundary - carWidth / 2))
        carHorizontalPosition += carHorizontalVelocity * Float(timePassed)
        carHorizontalPosition.clamp(to: bounds)
        carNode.worldPosition.x = carHorizontalPosition

        print("---")
        print("Phone Rotation Percetange: \(motion.getRotationPercentage())")
        print("Horizontal acceleration: \(carHorizontalAcceleration)")
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
