import Foundation

public struct Sphere {
    public func intersect(_ ray: Ray) -> [Double] {
        let sphereToRay = ray.origin - point(0, 0, 0)    // For now, the sphere is centered at the world origin.
        let a = ray.direction.dot(ray.direction)
        let b = 2 * ray.direction.dot(sphereToRay)
        let c = sphereToRay.dot(sphereToRay) - 1
        let discriminant = pow(b, 2) - 4 * a * c
        if discriminant < 0 {
            return []
        } else {
            let t1 = (-b - discriminant.squareRoot()) / (2 * a)
            let t2 = (-b + discriminant.squareRoot()) / (2 * a)
            return [t1, t2].sorted()
        }
    }
}
