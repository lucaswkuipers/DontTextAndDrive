extension Float {
    func clamped(to magnitude: Float) -> Float {
        let magnitude = abs(magnitude)
        if abs(self) > magnitude {
            return magnitude * self.getSign()
        } else {
            return self
        }
    }
}
