import SceneKit

final class GameSceneRendererDelegate: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    private let motion = MotionManager()
    private var lastTime = 0.0

    private var roadMarks: [SCNNode] = []

    private var carNode: SCNNode?
    private var carFrontVelocity = 8.3 // m/s
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
        // First time
        if lastTime == 0 && roadMarks.count <= 0 {
            // Connect road marks
            for i in -1...11 {
                if let roadMarkNode = scene?.rootNode.childNode(withName: "road_mark_\(i)", recursively: true) {
                    roadMarks.append(roadMarkNode)
                }
            }
        }

        // Time Update
        let timePassed = getTimePassed(from: lastTime, to: time)
        updateTime(to: time)
        if timePassed >= 0.1 { return }

        // Game loop
        moveCarHorizontally(timePassed: timePassed)

        // Move road marks
        for roadMark in roadMarks {
            roadMark.worldPosition.z += Float(timePassed * carFrontVelocity)
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
