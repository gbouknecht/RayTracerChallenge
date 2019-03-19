public protocol Object {
    var material: Material { get set }

    func intersect(_ ray: Ray) -> Intersections
    func normalAt(_ worldPoint: Tuple) -> Tuple
}
