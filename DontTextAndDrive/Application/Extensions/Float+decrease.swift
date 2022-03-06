extension Float {
    mutating func decrease(at percentage: Float, roundingAt minimum: Float) {
        if abs(self) < abs(minimum) { self = 0 }
        self *= abs(percentage)
    }
}
