public struct Material: Equatable {
    public var color: Color
    public var ambient: Double
    public var diffuse: Double
    public var specular: Double
    public var shininess: Double
    
    public init(color: Color = .white,
                ambient: Double = 0.1,
                diffuse: Double = 0.9,
                specular: Double = 0.9,
                shininess: Double = 200.0) {
        self.color = color
        self.ambient = ambient
        self.diffuse = diffuse
        self.specular = specular
        self.shininess = shininess
    }
}
