extension Double {
    func isBetween(_ lowerBound: Double, and upperBound: Double) -> Bool {
        self >= lowerBound && self <= upperBound
    }
}
