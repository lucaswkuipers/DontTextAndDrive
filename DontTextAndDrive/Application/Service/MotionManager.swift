import CoreMotion

final class MotionManager: CMMotionManager {

    override init() {
        super.init()
        startAccelerometerUpdates()
    }

    func getRotation() -> Double {
        let rotation = (accelerometerData?.acceleration.x ?? 0).clamped(to: 0.125)
        return rotation
    }
}
