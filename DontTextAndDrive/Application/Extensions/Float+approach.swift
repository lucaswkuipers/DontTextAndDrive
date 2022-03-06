extension Float {
    mutating func approach(_ targetValue: Float, by rate: Float, roundingDelta threshold: Float) {
        let isLesserThanTargetValue = self < targetValue
        let operationSign: Float = isLesserThanTargetValue ? 1 : -1
        let updatedSelf = self + operationSign * rate

        if abs(updatedSelf - targetValue) < abs(threshold) {
            self = targetValue
        } else {
            self = updatedSelf
        }
    }

    mutating func approach(_ targetValue: Float, percentually: Float, roundingDelta threshold: Float) {
        if abs(self) <= 0 {
            self = targetValue.getSign() * 0.01
            return
        }

        let isLesserThanTargetValue = abs(self) < abs(targetValue)
        let operationSign: Float = isLesserThanTargetValue ? 1 : -1
        let updatedSelf = self * (1 + percentually * operationSign)

        if abs(updatedSelf - targetValue) < abs(threshold) {
            self = targetValue
        } else {
            self = updatedSelf
        }
    }

    mutating func decelerate(to targetValue: Float, by percentage: Float) {
        guard abs(self) > abs(targetValue) else { return }
        self *= percentage
    }

    mutating func accelerate(to targetValue: Float, by rate: Float) {
        let isLesserThanTargetValue = self < targetValue
        let operationSign: Float = isLesserThanTargetValue ? 1 : -1
        let newValue = self + operationSign * rate
        self = newValue.clamped(to: targetValue)
    }
}
