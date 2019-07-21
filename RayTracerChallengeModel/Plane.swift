import Foundation

public struct Plane: Shape, Equatable {
    public let transform: Matrix
    public var material: Material

    public init(transform: Matrix = identity(), material: Material = Material()) {
        self.transform = transform
        self.material = material
    }

    public func localIntersect(_ localRay: Ray) -> Intersections {
        if equal(localRay.direction.y, 0) {
            return Intersections()
        } else {
            let t = -localRay.origin.y / localRay.direction.y
            return Intersections([Intersection(t, self)])
        }
    }

    public func localNormalAt(_ localPoint: Tuple) -> Tuple {
        return vector(0, 1, 0)
    }
}
