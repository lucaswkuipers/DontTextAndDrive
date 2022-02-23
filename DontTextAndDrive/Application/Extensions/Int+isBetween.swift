extension Int {
    func isBetween(_ lowerBound: Int, and upperBound: Int) -> Bool {
        self >= lowerBound && self <= upperBound
    }
}
