public struct Matrix {
    private let matrix: [[Double]]
    
    public init(_ matrix: [[Double]]) {
        assert(matrix.count > 0)
        assert(matrix.allSatisfy({ $0.count == matrix[0].count }))
        self.matrix = matrix
    }
  
    public init(identityWithSize size: Int) {
        assert(size > 0)
        var matrix = Array(repeating: Array(repeating: 0.0, count: size), count: size)
        (0..<size).forEach({ matrix[$0][$0] = 1 })
        self.init(matrix)
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
}

// MARK: - Operations

extension Matrix {
    public static func *(_ a: Matrix, _ b: Matrix) -> Matrix {
        assert(a.colCount() == b.rowCount())
        let matrix = (0..<a.rowCount())
            .map { row in (0..<b.colCount())
                .map { col in (0..<a.colCount())
                    .map { i in a[row, i] * b[i, col] }
                    .reduce(0, +) } }
        return Matrix(matrix)
    }
    
    public static func *(_ a: Matrix, _ b: Tuple) -> Tuple {
        assert(a.rowCount() == 4 && a.colCount() == 4)
        let m = a * Matrix([[b.x], [b.y], [b.z], [b.w]])
        return Tuple(m[0, 0], m[1, 0], m[2, 0], m[3, 0])
    }
    
    public func transposed() -> Matrix {
        let matrix = (0..<colCount())
            .map { row in (0..<rowCount())
                .map { col in self[col, row] } }
        return Matrix(matrix)
    }
    
    private func rowCount() -> Int {
        return matrix.count
    }
    
    private func colCount() -> Int {
        return matrix[0].count
    }
}
