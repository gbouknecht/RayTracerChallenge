import Foundation

public func translation(_ x: Double, _ y: Double, _ z: Double) -> Matrix {
    return Matrix([
        [1 , 0 , 0 , x],
        [0 , 1 , 0 , y],
        [0 , 0 , 1 , z],
        [0 , 0 , 0 , 1]])
}

public func scaling(_ x: Double, _ y: Double, _ z: Double) -> Matrix {
    return Matrix([
        [x , 0 , 0 , 0],
        [0 , y , 0 , 0],
        [0 , 0 , z , 0],
        [0 , 0 , 0 , 1]])
}

public func rotationx(_ radians: Double) -> Matrix {
    let s = sin(radians)
    let c = cos(radians)
    return Matrix([
        [1 , 0 ,  0 , 0],
        [0 , c , -s , 0],
        [0 , s ,  c , 0],
        [0 , 0 ,  0 , 1]])
}

public func rotationy(_ radians: Double) -> Matrix {
    let s = sin(radians)
    let c = cos(radians)
    return Matrix([
        [ c , 0 , s , 0],
        [ 0 , 1 , 0 , 0],
        [-s , 0 , c , 0],
        [ 0 , 0 , 0 , 1]])
}

public func rotationz(_ radians: Double) -> Matrix {
    let s = sin(radians)
    let c = cos(radians)
    return Matrix([
        [c , -s , 0 , 0],
        [s ,  c , 0 , 0],
        [0 ,  0 , 1 , 0],
        [0 ,  0 , 0 , 1]])
}
