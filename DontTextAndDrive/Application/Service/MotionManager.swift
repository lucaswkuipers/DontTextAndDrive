import CoreMotion

final class MotionManager: CMMotionManager {

    override init() {
        super.init()
        startAccelerometerUpdates()
    }

    public func getRotation() -> Float {
        return Float(accelerometerData?.acceleration.x ?? 0)
    }

    public func getInclination() -> Float {
        return Float(accelerometerData?.acceleration.y ?? 0)
    }
}
