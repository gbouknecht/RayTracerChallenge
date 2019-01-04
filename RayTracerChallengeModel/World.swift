public struct World {
    public let light: PointLight?
    public let objects: [Any]
    
    public init(light: PointLight? = nil, objects: [Any] = [Any]()) {
        self.light = light
        self.objects = objects
    }
}
