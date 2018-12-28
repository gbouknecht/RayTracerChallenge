public struct Matrix {
    private let rowCount: Int
    private let columnCount: Int
    private let values: [Double]
    
    private var rowIndices: Range<Int> { return 0..<rowCount }
    private var columnIndices: Range<Int> { return 0..<columnCount }
    
    public init(_ matrix: [[Double]]) {
        let rowCount = matrix.count
        let columnCount = matrix.first?.count ?? 0
        assert(rowCount > 0 && columnCount > 0)
        assert(matrix.allSatisfy { $0.count == columnCount })
        self.init(rowCount, columnCount, matrix.flatMap { $0 })
    }
  
    public init(identityWithSize size: Int) {
        assert(size > 0)
        let values = pairs(0..<size, 0..<size).map { (row, col) in row == col ? 1.0 : 0.0 }
        self.init(size, size, values)
    }
    
    private init(_ rowCount: Int, _ columnCount: Int, _ values: [Double]) {
        assert(rowCount * columnCount == values.count)
        self.rowCount = rowCount
        self.columnCount = columnCount
        self.values = values
    }

    public subscript(row: Int, col: Int) -> Double {
        get {
            return values[row * columnCount + col]
        }
    }
}

// MARK: - Equatable

extension Matrix: Equatable {
    public static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
        return zip(lhs.values, rhs.values).allSatisfy(equal)
    }
}

// MARK: - Operations

extension Matrix {
    public static func *(_ a: Matrix, _ b: Matrix) -> Matrix {
        assert(a.columnCount == b.rowCount)
        let value = { (row, col) in a.columnIndices.map { i in a[row, i] * b[i, col] }.reduce(0, +) }
        let values = pairs(a.rowIndices, b.columnIndices).map(value)
        return Matrix(a.rowCount, b.columnCount, values)
    }
    
    public static func *(_ a: Matrix, _ b: Tuple) -> Tuple {
        assert(a.rowCount == 4 && a.columnCount == 4)
        let m = a * Matrix(4, 1, [b.x, b.y, b.z, b.w])
        return Tuple(m[0, 0], m[1, 0], m[2, 0], m[3, 0])
    }
    
    public func transposed() -> Matrix {
        let values = pairs(columnIndices, rowIndices).map { (row, col) in self[col, row] }
        return Matrix(columnCount, rowCount, values)
    }
    
    public func determinant() -> Double {
        assert(rowCount > 1 && rowCount == columnCount)
        if rowCount == 2 {
            return self[0, 0] * self[1, 1] - self[0, 1] * self[1, 0]
        } else {
            return columnIndices.map { col in self[0, col] * cofactor(0, col) }.reduce(0, +)
        }
    }
    
    public func submatrix(_ rowToBeRemoved: Int, _ colToBeRemoved: Int) -> Matrix {
        assert(rowCount > 1 && rowCount == columnCount)
        let values = pairs(rowIndices, columnIndices)
            .filter { (row, col) in row != rowToBeRemoved && col != colToBeRemoved }
            .map { (row, col) in self[row, col] }
        return Matrix(rowCount - 1, columnCount - 1, values)
    }
    
    public func minor(_ row: Int, _ column: Int) -> Double {
        assert(rowCount > 1 && rowCount == columnCount)
        return submatrix(row, column).determinant()
    }
    
    public func cofactor(_ row: Int, _ column: Int) -> Double {
        assert(rowCount > 1 && rowCount == columnCount)
        return (row + column) % 2 == 0 ? minor(row, column) : -minor(row, column)
    }
}
