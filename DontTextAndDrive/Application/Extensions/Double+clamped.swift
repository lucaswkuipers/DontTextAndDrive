extension Double {
    func clamped(to magnitude: Double) -> Double {
        let magnitude = abs(magnitude)
        if abs(self) > magnitude {
            return magnitude * self.getSign()
        } else {
            return self
        }
    }
}
