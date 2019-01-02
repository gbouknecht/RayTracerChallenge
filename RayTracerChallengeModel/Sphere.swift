import Foundation

public struct Sphere: Equatable {
    private let id = UUID()
    
    public let transform: Matrix
    
    public init() {
        transform = identity()
    }
    
    public init(transform: Matrix) {
        self.transform = transform
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
}
