public struct World {
    public let light: PointLight?
    public let objects: [Object]
    
    public init(light: PointLight? = nil, objects: [Object] = [Object]()) {
        self.light = light
        self.objects = objects
    }
    
    public func intersect(_ ray: Ray) -> Intersections {
        let intersections = objects
            .map { $0.intersect(ray) }
            .flatMap { $0.intersections }
            .sorted { $0.t < $1.t }
        return Intersections(intersections)
    }
}
