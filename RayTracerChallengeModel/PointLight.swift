public struct PointLight {
    let position: Tuple
    let intensity: Color
    
    public init(_ position: Tuple, _ intensity: Color) {
        self.position = position
        self.intensity = intensity
    }
}
