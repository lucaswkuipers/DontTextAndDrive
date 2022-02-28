extension Double {
    func clamped(to magnitude: Double) -> Double {
        if abs(self) > magnitude {
            return magnitude * self.getSign()
        } else {
            return self
        }
    }
}
