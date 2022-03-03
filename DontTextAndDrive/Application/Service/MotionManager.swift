import CoreMotion

final class MotionManager: CMMotionManager {

    override init() {
        super.init()
        startAccelerometerUpdates()
    }

    public func getRotation() -> Double {
        let rotation = (accelerometerData?.acceleration.x ?? 0).clamped(to: 0.125)
        log("Rotation: \(rotation)")
        return rotation
    }
}
