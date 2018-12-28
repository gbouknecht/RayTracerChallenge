import XCTest
@testable import RayTracerChallengeModel

class MatrixTests: XCTestCase {
    func testMatrixCanCreate4By4Matrix() {
        let m = Matrix([
            [ 1   ,    2 ,    3 ,    4],
            [ 5.5 ,  6.5 ,  7.5 ,  8.5],
            [ 9   ,   10 ,   11 ,   12],
            [13.5 , 14.5 , 15.5 , 16.5]])
        XCTAssertEqual(m[0, 0], 1)
        XCTAssertEqual(m[0, 3], 4)
        XCTAssertEqual(m[1, 0], 5.5)
        XCTAssertEqual(m[1, 2], 7.5)
        XCTAssertEqual(m[2, 2], 11)
        XCTAssertEqual(m[3, 0], 13.5)
        XCTAssertEqual(m[3, 2], 15.5)
    }
    
    func testMatrixCanCreate2By2Matrix() {
        let m = Matrix([
            [-3 ,  5],
            [ 1 , -2]])
        XCTAssertEqual(m[0, 0], -3)
        XCTAssertEqual(m[0, 1], 5)
        XCTAssertEqual(m[1, 0], 1)
        XCTAssertEqual(m[1, 1], -2)
    }
    
    func testMatrixCanCreate3By3Matrix() {
        let m = Matrix([
            [-3 ,  5 ,  0],
            [ 1 , -2 , -7],
            [ 0 ,  1 ,  1]])
        XCTAssertEqual(m[0, 0], -3)
        XCTAssertEqual(m[1, 1], -2)
        XCTAssertEqual(m[2, 2], 1)
    }
    
    func testMatrixEqualityShouldAllowSlightDifferences() {
        let a = Matrix([
            [1 , 2 , 3 , 4],
            [5 , 6 , 7 , 8],
            [9 , 8 , 7 , 6],
            [5 , 4 , 3 , 2]])
        let b0 = Matrix([
            [0.999991 , 2.000009 , 3        , 4],
            [5        , 6        , 7        , 8],
            [9        , 8        , 6.999991 , 6],
            [5        , 4.000009 , 3        , 2]])
        let b1 = Matrix([
            [1 , 2 , 3        , 4],
            [5 , 6 , 7        , 8],
            [9 , 8 , 6.999989 , 6],
            [5 , 4 , 3        , 2]])
        let b2 = Matrix([
            [1 , 2 , 3        , 4],
            [5 , 6 , 7        , 8],
            [9 , 8 , 7.000011 , 6],
            [5 , 4 , 3        , 2]])
        XCTAssertEqual(a, b0)
        XCTAssertNotEqual(a, b1)
        XCTAssertNotEqual(a, b2)
    }
    
    func testMatricesCanBeMultiplied() {
        let a = Matrix([
            [1 , 2 , 3 , 4],
            [5 , 6 , 7 , 8],
            [9 , 8 , 7 , 6],
            [5 , 4 , 3 , 2]])
        let b = Matrix([
            [-2 , 1 , 2 ,  3],
            [ 3 , 2 , 1 , -1],
            [ 4 , 3 , 6 ,  5],
            [ 1 , 2 , 7 ,  8]])
        XCTAssertEqual(a * b, Matrix([
            [20 , 22 ,  50 ,  48],
            [44 , 54 , 114 , 108],
            [40 , 58 , 110 , 102],
            [16 , 26 ,  46 ,  42]]))
    }
    
    func testMatricesWithDifferentDimensionsCanBeMultiplied() {
        let a = Matrix([
            [1 ,  2 ,  3 ,  4],
            [5 ,  6 ,  7 ,  8],
            [9 , 10 , 11 , 12]])
        let b = Matrix([
            [13],
            [14],
            [15],
            [16]])
        XCTAssertEqual(a * b, Matrix([
            [150],
            [382],
            [614]]))
    }
    
    func testMatrixCanBeMultipliedByTuple() {
        let a = Matrix([
            [1 , 2 , 3 , 4],
            [2 , 4 , 4 , 2],
            [8 , 6 , 4 , 1],
            [0 , 0 , 0 , 1]])
        let b = Tuple(1, 2, 3, 1)
        XCTAssertEqual(a * b, Tuple(18, 24, 33, 1))
    }
    
    func testMatrixMultipliedByIdentityMatrixGivesSameMatrix() {
        let a = Matrix([
            [0 , 1 ,  2 ,  4],
            [1 , 2 ,  4 ,  8],
            [2 , 4 ,  8 , 16],
            [4 , 8 , 16 , 32]])
        XCTAssertEqual(a * Matrix(identityWithSize: 4), a)
    }
    
    func testIdentityMatrixMultipliedByTupleGivesSameTuple() {
        let a = Tuple(1, 2, 3, 4)
        XCTAssertEqual(Matrix(identityWithSize: 4) * a, a)
    }
    
    func testMatrixCanBeTransposed() {
        let a = Matrix([
            [0 , 9 , 3 , 0],
            [9 , 8 , 0 , 8],
            [1 , 8 , 5 , 3],
            [0 , 0 , 5 , 8]])
        XCTAssertEqual(a.transposed(), Matrix([
            [0 , 9 , 1 , 0],
            [9 , 8 , 8 , 0],
            [3 , 0 , 5 , 5],
            [0 , 8 , 3 , 8]]))
    }
    
    func testNonSquareMatrixCanBeTransposed() {
        let a = Matrix([
            [1 , 2],
            [3 , 4],
            [5 , 6]])
        XCTAssertEqual(a.transposed(), Matrix([
            [1 , 3 , 5],
            [2 , 4 , 6]]))
    }
    
    func testIdentityMatrixTransposedGivesSameMatrix() {
        let a = Matrix(identityWithSize: 4)
        XCTAssertEqual(a.transposed(), a)
    }
    
    func testMatrixCanCalculateDeterminantFor2By2Matrix() {
        let a = Matrix([
            [ 1 , 5],
            [-3 , 2]])
        XCTAssertEqual(a.determinant(), 17)
    }
    
    func testSubmatrixOf3By3MatrixGives2By2Matrix() {
        let a = Matrix([
            [ 1 , 5 ,  0],
            [-3 , 2 ,  7],
            [ 0 , 6 , -3]])
        XCTAssertEqual(a.submatrix(0, 2), Matrix([
            [-3 , 2],
            [ 0 , 6]]))
    }
    
    func testSubmatrixOf4By4MatrixGives3By3Matrix() {
        let a = Matrix([
            [-6 , 1 ,  1 , 6],
            [-8 , 5 ,  8 , 6],
            [-1 , 0 ,  8 , 2],
            [-7 , 1 , -1 , 1]])
        XCTAssertEqual(a.submatrix(2, 1), Matrix([
            [-6 ,  1 , 6],
            [-8 ,  8 , 6],
            [-7 , -1 , 1]]))
    }
    
    func testMatrixCanCalculateMinorFor3By3Matrix() {
        let a = Matrix([
            [3 ,  5 ,  0],
            [2 , -1 , -7],
            [6 , -1 ,  5]])
        let b = a.submatrix(1, 0)
        XCTAssertEqual(b.determinant(), 25)
        XCTAssertEqual(a.minor(1, 0), 25)
    }
}
