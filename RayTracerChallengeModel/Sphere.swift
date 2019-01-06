import Foundation

public struct Sphere: Object, Equatable {
    public let transform: Matrix
    public let material: Material

    public init(transform: Matrix = identity(), material: Material = Material()) {
        self.transform = transform
        self.material = material
    }
    
    public func intersect(_ ray: Ray) -> Intersections {
        let transformedRay = ray.transformed(transform.inverted())
        let sphereToTransformedRay = transformedRay.origin - point(0, 0, 0)    // For now, the sphere is centered at the world origin.
        let a = transformedRay.direction.dot(transformedRay.direction)
        let b = 2 * transformedRay.direction.dot(sphereToTransformedRay)
        let c = sphereToTransformedRay.dot(sphereToTransformedRay) - 1
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
    
    public func normalAt(_ worldPoint: Tuple) -> Tuple {
        assert(worldPoint.isPoint())
        let objectPoint = transform.inverted() * worldPoint
        let objectNormal = objectPoint - point(0, 0, 0)    // For now, the sphere is centered at the world origin.
        let worldNormal = transform.inverted().transposed() * objectNormal
        return vector(worldNormal.x, worldNormal.y, worldNormal.z).normalized()
    }
}
