import Foundation

public struct Tuple {
    public let x: Double
    public let y: Double
    public let z: Double
    public let w: Double
    
    public init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
}

// MARK: - Equatable

extension Tuple: Equatable {
    public static func ==(lhs: Tuple, rhs: Tuple) -> Bool {
        return equal(lhs.x, rhs.x)
            && equal(lhs.y, rhs.y)
            && equal(lhs.z, rhs.z)
            && equal(lhs.w, rhs.w)
    }
}

// MARK: - Operations

extension Tuple {
    public static func +(_ a: Tuple, _ b: Tuple) -> Tuple {
        return Tuple(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)
    }
    
    public static func -(_ a: Tuple, _ b: Tuple) -> Tuple {
        return Tuple(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)
    }
    
    public static prefix func -(_ a: Tuple) -> Tuple {
        return Tuple(-a.x, -a.y, -a.z, -a.w)
    }
    
    public static func *(_ a: Tuple, _ b: Double) -> Tuple {
        return Tuple(a.x * b, a.y * b, a.z * b, a.w * b)
    }
    
    public static func /(_ a: Tuple, _ b: Double) -> Tuple {
        return Tuple(a.x / b, a.y / b, a.z / b, a.w / b)
    }
}

// MARK: - Points

extension Tuple {
    private static let wValueForPoint = 1.0
    
    public init(fromPoint x: Double, _ y: Double, _ z: Double) {
        self.init(x, y, z, Tuple.wValueForPoint)
    }

    public func isPoint() -> Bool {
        return w == Tuple.wValueForPoint
    }
}

public func point(_ x: Double, _ y: Double, _ z: Double) -> Tuple {
    return Tuple(fromPoint: x, y, z)
}

// MARK: - Vectors

extension Tuple {
    private static let wValueForVector = 0.0
    
    public init(fromVector x: Double, _ y: Double, _ z: Double) {
        self.init(x, y, z, Tuple.wValueForVector)
    }
    
    public func isVector() -> Bool {
        return w == Tuple.wValueForVector
    }
}

public func vector(_ x: Double, _ y: Double, _ z: Double) -> Tuple {
    return Tuple(fromVector: x, y, z)
}

extension Tuple {
    public var magnitude: Double {
        assert(isVector())
        return (pow(x, 2) + pow(y, 2) + pow(z, 2) + pow(w, 2)).squareRoot()
    }
        
    public func normalized() -> Tuple {
        assert(isVector())
        let m = magnitude
        return Tuple(x / m, y / m, z / m, w / m)
    }
    
    public func dot(_ b: Tuple) -> Double {
        let a = self
        assert(a.isVector() && b.isVector())
        return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w
    }
    
    public func cross(_ b: Tuple) -> Tuple {
        let a = self
        assert(a.isVector() && b.isVector())
        return vector(a.y * b.z - a.z * b.y,
                      a.z * b.x - a.x * b.z,
                      a.x * b.y - a.y * b.x)
    }
    
    public func reflected(_ normal: Tuple) -> Tuple {
        assert(isVector() && normal.isVector())
        return self - normal * 2 * dot(normal)
    }
}
