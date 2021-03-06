public struct PreparedComputations {
    public let t: Double
    public let object: Shape
    public let point: Tuple
    public let eyev: Tuple
    public let normalv: Tuple
    public let inside: Bool
    public let overPoint: Tuple

    public init(intersection: Intersection, ray: Ray) {
        t = intersection.t
        object = intersection.object
        point = ray.position(t)
        eyev = -ray.direction
        (normalv, inside) = normalvAndInside(object, point, eyev)
        overPoint = point + normalv * epsilon
    }
}

fileprivate func normalvAndInside(_ object: Shape, _ point: Tuple, _ eyev: Tuple) -> (Tuple, Bool) {
    let normalv = object.normalAt(point)
    if normalv.dot(eyev) < 0 {
        return (-normalv, true)
    } else {
        return (normalv, false)
    }
}
