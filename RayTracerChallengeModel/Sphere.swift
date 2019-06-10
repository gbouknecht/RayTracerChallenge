import Foundation

public struct Sphere: Shape, Equatable {
    public let transform: Matrix
    public var material: Material

    public init(transform: Matrix = identity(), material: Material = Material()) {
        self.transform = transform
        self.material = material
    }
    
    public func localIntersect(_ localRay: Ray) -> Intersections {
        let sphereToLocalRay = localRay.origin - point(0, 0, 0)    // For now, the sphere is centered at the world origin.
        let a = localRay.direction.dot(localRay.direction)
        let b = 2 * localRay.direction.dot(sphereToLocalRay)
        let c = sphereToLocalRay.dot(sphereToLocalRay) - 1
        let discriminant = pow(b, 2) - 4 * a * c
        if discriminant < 0 {
            return Intersections()
        } else {
            let t1 = (-b - discriminant.squareRoot()) / (2 * a)
            let t2 = (-b + discriminant.squareRoot()) / (2 * a)
            let intersections = [t1, t2].sorted().map { Intersection($0, self) }
            return Intersections(intersections)
        }
    }
    
    public func localNormalAt(_ localPoint: Tuple) -> Tuple {
        return localPoint - point(0, 0, 0)    // For now, the sphere is centered at the world origin.
    }
}
