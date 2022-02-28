import CoreMotion

final class MotionManager: CMMotionManager {

    override init() {
        super.init()
        startAccelerometerUpdates()
    }

    public func getRotation() -> Float {
        let rotation = Float((accelerometerData?.acceleration.x ?? 0).clamped(to: 0.125))
        print("Rotation: \(rotation)")
        return rotation
    }
}
