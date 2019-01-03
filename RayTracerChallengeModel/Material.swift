public struct Material: Equatable {
    public let color: Color
    public let ambient: Double
    public let diffuse: Double
    public let specular: Double
    public let shininess: Double
    
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
