public struct Matrix {
    private let matrix: [[Double]]
    
    public init(_ matrix: [[Double]]) {
        assert(matrix.count > 0)
        assert(matrix.allSatisfy({ $0.count == matrix[0].count }))
        self.matrix = matrix
    }
    
    public subscript(row: Int, col: Int) -> Double {
        get {
            return matrix[row][col]
        }
    }
}

// MARK: - Equatable

extension Matrix: Equatable {
    public static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
        let flattenedLhs = lhs.matrix.flatMap { $0 }
        let flattenedRhs = rhs.matrix.flatMap { $0 }
        return zip(flattenedLhs, flattenedRhs).allSatisfy({ (a, b) in equal(a, b) })
    }
    
    private static func equal(_ a: Double, _ b: Double) -> Bool {
        return abs(a - b) < 0.00001
    }
}
