import CoreGraphics

extension CGFloat {
    func isBetween(_ lowerBound: CGFloat, and upperBound: CGFloat) -> Bool {
        self >= lowerBound && self <= upperBound
    }
}
