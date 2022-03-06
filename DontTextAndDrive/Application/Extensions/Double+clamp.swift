extension Double {
    mutating func clamp(to magnitude: Double) {
        let magnitude = abs(magnitude)
        guard abs(self) > magnitude else { return }
        self = magnitude * self.getSign()
    }
}
