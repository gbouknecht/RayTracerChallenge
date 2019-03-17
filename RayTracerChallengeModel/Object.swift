public protocol Object {
    var material: Material { get }

    func intersect(_ ray: Ray) -> Intersections
    func normalAt(_ worldPoint: Tuple) -> Tuple
}
