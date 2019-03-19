public struct World {
    public var light: PointLight?
    public var objects: [Object]
    
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

    public func shadeHit(_ comps: PreparedComputations) -> Color {
        assert(light != nil)
        return lighting(material: comps.object.material,
                        light: light!,
                        point: comps.point,
                        eyev: comps.eyev,
                        normalv: comps.normalv)
    }

    public func colorAt(_ ray: Ray) -> Color {
        if let hit = intersect(ray).hit() {
            return shadeHit(PreparedComputations(intersection: hit, ray: ray))
        } else {
            return .black
        }
    }
}
