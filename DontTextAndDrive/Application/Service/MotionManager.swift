import CoreMotion

final class MotionManager: CMMotionManager {
    private let maximumRotation = 0.125

    override init() {
        super.init()
        startAccelerometerUpdates()
    }

    func getRotation() -> Double {
        return (accelerometerData?.acceleration.x ?? 0).clamped(to: maximumRotation)
    }

    func getRotationPercentage() -> Double {
        return (accelerometerData?.acceleration.x ?? 0).clamped(to: maximumRotation) / maximumRotation
    }
}
