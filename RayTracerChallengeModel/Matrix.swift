public struct Matrix {
    private let matrix: [[Double]]
    
    private var rowCount: Int { return matrix.count }
    private var rowIndices: Range<Int> { return 0..<rowCount }
    private var columnCount: Int { return matrix[0].count }
    private var columnIndices: Range<Int> { return 0..<columnCount }
    
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
        assert(a.columnCount == b.rowCount)
        let matrix = a.rowIndices
            .map { row in b.columnIndices
                .map { col in a.columnIndices
                    .map { i in a[row, i] * b[i, col] }
                    .reduce(0, +) } }
        return Matrix(matrix)
    }
    
    public static func *(_ a: Matrix, _ b: Tuple) -> Tuple {
        assert(a.rowCount == 4 && a.columnCount == 4)
        let m = a * Matrix([[b.x], [b.y], [b.z], [b.w]])
        return Tuple(m[0, 0], m[1, 0], m[2, 0], m[3, 0])
    }
    
    public func transposed() -> Matrix {
        let matrix = columnIndices.map { row in rowIndices.map { col in self[col, row] } }
        return Matrix(matrix)
    }
    
    public func determinant() -> Double {
        assert(rowCount == 2 && columnCount == 2)
        return self[0, 0] * self[1, 1] - self[0, 1] * self[1, 0]
    }
    
    public func submatrix(removedRow rowToBeRemoved: Int, andColumn colToBeRemoved: Int) -> Matrix {
        assert(rowCount == columnCount)
        assert(rowCount > 1 && columnCount > 1)
        let matrix = rowIndices
            .filter { row in row != rowToBeRemoved }
            .map { row in columnIndices
                .filter  { col in col != colToBeRemoved}
                .map { col in self[row, col] } }
        return Matrix(matrix)
    }
}
