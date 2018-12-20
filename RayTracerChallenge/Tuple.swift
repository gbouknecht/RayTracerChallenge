import Foundation

struct Tuple {
    private static let wValueForPoint = 1.0
    private static let wValueForVector = 0.0
    
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
    
    init(fromPoint x: Double, _ y: Double, _ z: Double) {
        self.init(x, y, z, Tuple.wValueForPoint)
    }
    
    init(fromVector x: Double, _ y: Double, _ z: Double) {
        self.init(x, y, z, Tuple.wValueForVector)
    }

    func isPoint() -> Bool {
        return w == Tuple.wValueForPoint
    }
    
    func isVector() -> Bool {
        return w == Tuple.wValueForVector
    }
}

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

extension Tuple {
    var magnitude: Double {
        assert(isVector())
        return (pow(x, 2) + pow(y, 2) + pow(z, 2) + pow(w, 2)).squareRoot()
    }
}
