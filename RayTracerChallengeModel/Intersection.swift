public struct Intersection {
    public let t: Double
    public let object: Shape
    
    public init(_ t: Double, _ object: Shape) {
        self.t = t
        self.object = object
    }
}
