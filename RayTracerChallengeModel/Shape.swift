public protocol Shape {
    var transform: Matrix { get }
    var material: Material { get set }

    func intersect(_ ray: Ray) -> Intersections
    func localIntersect(_ localRay: Ray) -> Intersections

    func normalAt(_ worldPoint: Tuple) -> Tuple
    func localNormalAt(_ localPoint: Tuple) -> Tuple
}

public extension Shape {
    func intersect(_ ray: Ray) -> Intersections {
        let localRay = ray.transformed(transform.inverted())
        return localIntersect(localRay)
    }

    func normalAt(_ worldPoint: Tuple) -> Tuple {
        assert(worldPoint.isPoint())
        let localPoint = transform.inverted() * worldPoint
        let localNormal = localNormalAt(localPoint)
        let worldNormal = transform.inverted().transposed() * localNormal
        return vector(worldNormal.x, worldNormal.y, worldNormal.z).normalized()
    }
}
