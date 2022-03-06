extension Numeric where Self:FloatingPoint {
    func getSign<T: FloatingPoint>() -> T {
        return self < 0 ? -1 : 1
    }
}

extension Double {
    func isSameSign(than value: Double) -> Bool {
        let thisSign: Double = getSign()
        let valueSign: Double = value.getSign()

        return thisSign == valueSign
    }
}

extension Float {
    func isSameSign(than value: Float) -> Bool {
        let thisSign: Float = getSign()
        let valueSign: Float = value.getSign()

        return thisSign == valueSign
    }
}
