public struct Ray {
    public let origin: Tuple
    public let direction: Tuple
    
    public init(_ origin: Tuple, _ direction: Tuple) {
        assert(origin.isPoint() && direction.isVector())
        self.origin = origin
        self.direction = direction
    }
    
    public func position(_ t: Double) -> Tuple {
        return origin + direction * t
    }
}
