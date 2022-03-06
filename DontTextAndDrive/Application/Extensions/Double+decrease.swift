extension Double {
    mutating func decrease(at percentage: Double, roundingAt minimum: Double) {
        if abs(self) < abs(minimum) { self = 0 }
        self *= abs(percentage)
    }
}
