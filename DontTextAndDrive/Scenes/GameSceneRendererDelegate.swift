import SceneKit

final class GameSceneRendererDelegate: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    private let motion = MotionManager()
    private var lastTime = 0.0

    private var carNode: SCNNode?
    private var carFrontVelocity: Float = 0.2 * 60
    private var carHorizontalPosition: Float = 0
    private var carHorizontalVelocity: Float = 0
    private let maximumCarHorizontalVelocity: Float = 3
    private let carWidth = 1.76784
    private let leftRoadBoundary = -3.7
    private let rightRoadBoundary = 3.7

    // Road mark
    private var lastSpawnedRoadMarkTime = 0.0
    private var roadMarks: [SCNNode] = []

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if carNode == nil {
            carNode = scene?.rootNode.childNode(withName: "camera", recursively: false)
        }

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
        guard let carNode = carNode else { return }

        // Apply force
        let factor = 30.0 * 60.0
        let bounds: Float = Float(abs(rightRoadBoundary - carWidth / 2))
        var carHorizontalVelocity = Float(motion.getRotation() * factor * timePassed)
        carHorizontalVelocity = carHorizontalVelocity.clamped(to: maximumCarHorizontalVelocity)
        carHorizontalPosition += carHorizontalVelocity * Float(timePassed)
        carHorizontalPosition = carHorizontalPosition.clamped(to: bounds)

        // Constraint car to road
        carNode.worldPosition.x = carHorizontalPosition

        print("Rotation: \(motion.getRotation())")
        print("Horizontal velocity: \(carHorizontalVelocity)")
        print("Horizontal position: \(carNode.worldPosition.x)")
        print("Moving car horizontally - : \(carNode.worldPosition.x)")

        self.carHorizontalVelocity = carHorizontalVelocity
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
