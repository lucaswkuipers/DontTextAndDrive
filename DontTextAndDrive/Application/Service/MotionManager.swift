import CoreMotion

final class MotionManager: CMMotionManager {
//    private let maximumRotation = 0.125
    private let maximumRotation = 0.2

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
