import CoreMotion

final class MotionManager: CMMotionManager {

    override init() {
        super.init()
        startAccelerometerUpdates()
    }

    public func getRotation() -> Double? {
        return accelerometerData?.acceleration.x
    }
}
