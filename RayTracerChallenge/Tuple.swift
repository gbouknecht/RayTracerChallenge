import Foundation

struct Tuple {
    let x: Double
    let y: Double
    let z: Double
    let w: Double
    
    init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
}

// MARK: - Equatable

extension Tuple: Equatable {
    static func ==(lhs: Tuple, rhs: Tuple) -> Bool {
        return equal(lhs.x, rhs.x)
            && equal(lhs.y, rhs.y)
            && equal(lhs.z, rhs.z)
            && equal(lhs.w, rhs.w)
    }
    
    private static func equal(_ a: Double, _ b: Double) -> Bool {
        return abs(a - b) < 0.00001
    }
}

// MARK: - Operations

extension Tuple {
    static func +(_ a: Tuple, _ b: Tuple) -> Tuple {
        return Tuple(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)
    }
    
    static func -(_ a: Tuple, _ b: Tuple) -> Tuple {
        return Tuple(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)
    }
    
    static prefix func -(_ a: Tuple) -> Tuple {
        return Tuple(-a.x, -a.y, -a.z, -a.w)
    }
    
    static func *(_ a: Tuple, _ b: Double) -> Tuple {
        return Tuple(a.x * b, a.y * b, a.z * b, a.w * b)
    }
    
    static func /(_ a: Tuple, _ b: Double) -> Tuple {
        return Tuple(a.x / b, a.y / b, a.z / b, a.w / b)
    }
}

// MARK: - Points

extension Tuple {
    private static let wValueForPoint = 1.0
    
    init(fromPoint x: Double, _ y: Double, _ z: Double) {
        self.init(x, y, z, Tuple.wValueForPoint)
    }

    func isPoint() -> Bool {
        return w == Tuple.wValueForPoint
    }
}

// MARK: - Vectors

extension Tuple {
    private static let wValueForVector = 0.0
    
    init(fromVector x: Double, _ y: Double, _ z: Double) {
        self.init(x, y, z, Tuple.wValueForVector)
    }
    
    func isVector() -> Bool {
        return w == Tuple.wValueForVector
    }
}

extension Tuple {
    var magnitude: Double {
        assert(isVector())
        return (pow(x, 2) + pow(y, 2) + pow(z, 2) + pow(w, 2)).squareRoot()
    }
        
    func normalized() -> Tuple {
        assert(isVector())
        let m = magnitude
        return Tuple(x / m, y / m, z / m, w / m)
    }
    
    func dot(_ b: Tuple) -> Double {
        let a = self
        assert(a.isVector() && b.isVector())
        return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w
    }
    
    func cross(_ b: Tuple) -> Tuple {
        let a = self
        assert(a.isVector() && b.isVector())
        return Tuple(fromVector: a.y * b.z - a.z * b.y,
                                 a.z * b.x - a.x * b.z,
                                 a.x * b.y - a.y * b.x)
    }
}
