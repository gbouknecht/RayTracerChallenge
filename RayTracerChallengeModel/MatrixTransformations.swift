import Foundation

public func identity() -> Matrix {
    return Matrix(identityWithSize: 4)
}

extension Matrix {
    public func translated(_ x: Double, _ y: Double, _ z: Double) -> Matrix {
        let transform = Matrix([
            [1 , 0 , 0 , x],
            [0 , 1 , 0 , y],
            [0 , 0 , 1 , z],
            [0 , 0 , 0 , 1]])
        return transform * self
    }
    
    public func scaled(_ x: Double, _ y: Double, _ z: Double) -> Matrix {
        let transform =  Matrix([
            [x , 0 , 0 , 0],
            [0 , y , 0 , 0],
            [0 , 0 , z , 0],
            [0 , 0 , 0 , 1]])
        return transform * self
    }
    
    public func rotatedAroundx(_ radians: Double) -> Matrix {
        let s = sin(radians)
        let c = cos(radians)
        let transform = Matrix([
            [1 , 0 ,  0 , 0],
            [0 , c , -s , 0],
            [0 , s ,  c , 0],
            [0 , 0 ,  0 , 1]])
        return transform * self
    }

    public func rotatedAroundy(_ radians: Double) -> Matrix {
        let s = sin(radians)
        let c = cos(radians)
        let transform = Matrix([
            [ c , 0 , s , 0],
            [ 0 , 1 , 0 , 0],
            [-s , 0 , c , 0],
            [ 0 , 0 , 0 , 1]])
        return transform * self
    }

    public func rotatedAroundz(_ radians: Double) -> Matrix {
        let s = sin(radians)
        let c = cos(radians)
        let transform = Matrix([
            [c , -s , 0 , 0],
            [s ,  c , 0 , 0],
            [0 ,  0 , 1 , 0],
            [0 ,  0 , 0 , 1]])
        return transform * self
    }
    
    public func sheared(xy: Double, xz: Double, yx: Double, yz: Double, zx: Double, zy: Double) -> Matrix {
        let transform = Matrix([
            [ 1 , xy , xz , 0],
            [yx ,  1 , yz , 0],
            [zx , zy ,  1 , 0],
            [ 0 ,  0 ,  0 , 1]])
        return transform * self
    }
}
