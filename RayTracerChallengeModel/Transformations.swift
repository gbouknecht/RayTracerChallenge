public func translation(_ x: Double, _ y: Double, _ z: Double) -> Matrix {
    return Matrix([
        [1 , 0 , 0 , x],
        [0 , 1 , 0 , y],
        [0 , 0 , 1 , z],
        [0 , 0 , 0 , 1]])
}
