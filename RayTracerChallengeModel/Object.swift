public protocol Object {
    func intersect(_ ray: Ray) -> Intersections
    func normalAt(_ worldPoint: Tuple) -> Tuple
}
