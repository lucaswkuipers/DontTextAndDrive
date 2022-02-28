extension Float {
    func clamped(to magnitude: Float) -> Float {
        if abs(self) > magnitude {
            return magnitude * self.getSign()
        } else {
            return self
        }
    }
}
