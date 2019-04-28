import Foundation

public func viewTransform(from: Tuple, to: Tuple, up: Tuple) -> Matrix {
    let forward = (to - from).normalized()
    let left = forward.cross(up.normalized())
    let trueUp = left.cross(forward)
    let orientation = Matrix([[left.x, left.y, left.z, 0],
                              [trueUp.x, trueUp.y, trueUp.z, 0],
                              [-forward.x, -forward.y, -forward.z, 0],
                              [0, 0, 0, 1]])
    return orientation * identity().translated(-from.x, -from.y, -from.z)
}
