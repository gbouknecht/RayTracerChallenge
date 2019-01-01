public struct Intersections {
    private let intersections: [Intersection]
    
    public var count: Int { return intersections.count }
    
    public init(_ intersections: Intersection...) {
        self.init(intersections)
    }
    
    public init(_ intersections: [Intersection]) {
        self.intersections = intersections
    }
    
    public subscript(index: Int) -> Intersection {
        return intersections[index]
    }
}
