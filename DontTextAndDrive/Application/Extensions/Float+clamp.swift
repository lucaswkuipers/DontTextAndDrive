extension Float {
    mutating func clamp(to magnitude: Float) {
        let magnitude = abs(magnitude)
        guard abs(self) > magnitude else { return }
        self = magnitude * self.getSign()
    }
}
