import SceneKit

final class GameSceneRendererDelegate: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene?
    private let motion = MotionManager()
    private var lastTime = 0.0

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let timePassed = getTimePassed(from: lastTime, to: time)
        moveCarHorizontally(timePassed: timePassed)
        updateTime(to: time)
    }

    private func getTimePassed(from previousTime: TimeInterval, to currentTime: TimeInterval) -> Double {
        guard previousTime > 0 else { return 0 }
        let timePassed = currentTime - previousTime
//        logTime(previousTime: previousTime, currentTime: currentTime, timePassed: timePassed)
        return timePassed
    }

    private func updateTime(to currentTime: TimeInterval) {
        lastTime = currentTime
    }

    private func moveCarHorizontally(timePassed: TimeInterval) {

        // Apply force
        guard let car = scene?.rootNode.childNode(withName: "car", recursively: true) else { return }
        let dxFactor = 60.0 * 4
        let dx = Float(motion.getRotation() * timePassed * dxFactor)
        let force = SCNVector3(x: dx, y: 0, z: 0)
        car.physicsBody?.applyForce(force, at: SCNVector3(x: 0, y: 0, z: 0), asImpulse: false)

        // Constraint car to road
        let position = car.presentation.worldPosition.x
        let bounds: Float = 4.5
        car.position.x = position.clamped(to: bounds)

        // Log
//        logCarMovement(dx: dx, position: position)

    }

    // MARK: - DEBUG
    private func logTime(previousTime: TimeInterval, currentTime: TimeInterval, timePassed: TimeInterval) {
        log("---")
        log("Last time: \(previousTime)")
        log("Current time: \(currentTime)")
        log("Time passed: \(timePassed)")
        log("---")
    }

    private func logCarMovement(dx: Float, position: Float) {
        log("Car dx: \(dx)")
        log("Car x position: \(position)")
    }
}
