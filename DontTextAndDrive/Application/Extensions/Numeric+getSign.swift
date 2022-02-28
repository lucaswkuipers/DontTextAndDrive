extension Numeric where Self:FloatingPoint {
    func getSign<T: FloatingPoint>() -> T {
        return self < 0 ? -1 : 1
    }
}
