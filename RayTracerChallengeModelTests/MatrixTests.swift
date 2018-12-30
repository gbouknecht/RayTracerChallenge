import XCTest
@testable import RayTracerChallengeModel

class MatrixTests: XCTestCase {
    func testMatrixCanCreate4By4Matrix() {
        let M = Matrix([
            [ 1   ,    2 ,    3 ,    4],
            [ 5.5 ,  6.5 ,  7.5 ,  8.5],
            [ 9   ,   10 ,   11 ,   12],
            [13.5 , 14.5 , 15.5 , 16.5]])
        XCTAssertEqual(M[0, 0], 1)
        XCTAssertEqual(M[0, 3], 4)
        XCTAssertEqual(M[1, 0], 5.5)
        XCTAssertEqual(M[1, 2], 7.5)
        XCTAssertEqual(M[2, 2], 11)
        XCTAssertEqual(M[3, 0], 13.5)
        XCTAssertEqual(M[3, 2], 15.5)
    }
    
    func testMatrixCanCreate2By2Matrix() {
        let M = Matrix([
            [-3 ,  5],
            [ 1 , -2]])
        XCTAssertEqual(M[0, 0], -3)
        XCTAssertEqual(M[0, 1], 5)
        XCTAssertEqual(M[1, 0], 1)
        XCTAssertEqual(M[1, 1], -2)
    }
    
    func testMatrixCanCreate3By3Matrix() {
        let M = Matrix([
            [-3 ,  5 ,  0],
            [ 1 , -2 , -7],
            [ 0 ,  1 ,  1]])
        XCTAssertEqual(M[0, 0], -3)
        XCTAssertEqual(M[1, 1], -2)
        XCTAssertEqual(M[2, 2], 1)
    }
    
    func testMatrixEqualityShouldAllowSlightDifferences() {
        let A = Matrix([
            [1 , 2 , 3 , 4],
            [5 , 6 , 7 , 8],
            [9 , 8 , 7 , 6],
            [5 , 4 , 3 , 2]])
        let B0 = Matrix([
            [0.999991 , 2.000009 , 3        , 4],
            [5        , 6        , 7        , 8],
            [9        , 8        , 6.999991 , 6],
            [5        , 4.000009 , 3        , 2]])
        let B1 = Matrix([
            [1 , 2 , 3        , 4],
            [5 , 6 , 7        , 8],
            [9 , 8 , 6.999989 , 6],
            [5 , 4 , 3        , 2]])
        let B2 = Matrix([
            [1 , 2 , 3        , 4],
            [5 , 6 , 7        , 8],
            [9 , 8 , 7.000011 , 6],
            [5 , 4 , 3        , 2]])
        XCTAssertEqual(A, B0)
        XCTAssertNotEqual(A, B1)
        XCTAssertNotEqual(A, B2)
    }
    
    func testMatricesCanBeMultiplied() {
        let A = Matrix([
            [1 , 2 , 3 , 4],
            [5 , 6 , 7 , 8],
            [9 , 8 , 7 , 6],
            [5 , 4 , 3 , 2]])
        let B = Matrix([
            [-2 , 1 , 2 ,  3],
            [ 3 , 2 , 1 , -1],
            [ 4 , 3 , 6 ,  5],
            [ 1 , 2 , 7 ,  8]])
        XCTAssertEqual(A * B, Matrix([
            [20 , 22 ,  50 ,  48],
            [44 , 54 , 114 , 108],
            [40 , 58 , 110 , 102],
            [16 , 26 ,  46 ,  42]]))
    }
    
    func testMatricesWithDifferentDimensionsCanBeMultiplied() {
        let A = Matrix([
            [1 ,  2 ,  3 ,  4],
            [5 ,  6 ,  7 ,  8],
            [9 , 10 , 11 , 12]])
        let B = Matrix([
            [13],
            [14],
            [15],
            [16]])
        XCTAssertEqual(A * B, Matrix([
            [150],
            [382],
            [614]]))
    }
    
    func testMatrixCanBeMultipliedByTuple() {
        let A = Matrix([
            [1 , 2 , 3 , 4],
            [2 , 4 , 4 , 2],
            [8 , 6 , 4 , 1],
            [0 , 0 , 0 , 1]])
        let B = Tuple(1, 2, 3, 1)
        XCTAssertEqual(A * B, Tuple(18, 24, 33, 1))
    }
    
    func testMatrixMultipliedByIdentityMatrixGivesSameMatrix() {
        let A = Matrix([
            [0 , 1 ,  2 ,  4],
            [1 , 2 ,  4 ,  8],
            [2 , 4 ,  8 , 16],
            [4 , 8 , 16 , 32]])
        XCTAssertEqual(A * Matrix(identityWithSize: 4), A)
    }
    
    func testIdentityMatrixMultipliedByTupleGivesSameTuple() {
        let A = Tuple(1, 2, 3, 4)
        XCTAssertEqual(Matrix(identityWithSize: 4) * A, A)
    }
    
    func testMatrixCanBeTransposed() {
        let A = Matrix([
            [0 , 9 , 3 , 0],
            [9 , 8 , 0 , 8],
            [1 , 8 , 5 , 3],
            [0 , 0 , 5 , 8]])
        XCTAssertEqual(A.transposed(), Matrix([
            [0 , 9 , 1 , 0],
            [9 , 8 , 8 , 0],
            [3 , 0 , 5 , 5],
            [0 , 8 , 3 , 8]]))
    }
    
    func testNonSquareMatrixCanBeTransposed() {
        let A = Matrix([
            [1 , 2],
            [3 , 4],
            [5 , 6]])
        XCTAssertEqual(A.transposed(), Matrix([
            [1 , 3 , 5],
            [2 , 4 , 6]]))
    }
    
    func testIdentityMatrixTransposedGivesSameMatrix() {
        let A = Matrix(identityWithSize: 4)
        XCTAssertEqual(A.transposed(), A)
    }
    
    func testMatrixCanCalculateDeterminantFor2By2Matrix() {
        let A = Matrix([
            [ 1 , 5],
            [-3 , 2]])
        XCTAssertEqual(A.determinant(), 17)
    }
    
    func testSubmatrixOf3By3MatrixGives2By2Matrix() {
        let A = Matrix([
            [ 1 , 5 ,  0],
            [-3 , 2 ,  7],
            [ 0 , 6 , -3]])
        XCTAssertEqual(A.submatrix(0, 2), Matrix([
            [-3 , 2],
            [ 0 , 6]]))
    }
    
    func testSubmatrixOf4By4MatrixGives3By3Matrix() {
        let A = Matrix([
            [-6 , 1 ,  1 , 6],
            [-8 , 5 ,  8 , 6],
            [-1 , 0 ,  8 , 2],
            [-7 , 1 , -1 , 1]])
        XCTAssertEqual(A.submatrix(2, 1), Matrix([
            [-6 ,  1 , 6],
            [-8 ,  8 , 6],
            [-7 , -1 , 1]]))
    }
    
    func testMatrixCanCalculateMinorFor3By3Matrix() {
        let A = Matrix([
            [3 ,  5 ,  0],
            [2 , -1 , -7],
            [6 , -1 ,  5]])
        let B = A.submatrix(1, 0)
        XCTAssertEqual(B.determinant(), 25)
        XCTAssertEqual(A.minor(1, 0), 25)
    }
    
    func testMatrixCanCalculateCofactorFor3By3Matrix() {
        let A = Matrix([
            [3 ,  5 ,  0],
            [2 , -1 , -7],
            [6 , -1 ,  5]])
        XCTAssertEqual(A.minor(0, 0), -12)
        XCTAssertEqual(A.cofactor(0, 0), -12)
        XCTAssertEqual(A.minor(1, 0), 25)
        XCTAssertEqual(A.cofactor(1, 0), -25)
    }
    
    func testMatrixCanCalculateDeterminantFor3By3Matrix() {
        let A = Matrix([
            [ 1 , 2 ,  6],
            [-5 , 8 , -4],
            [ 2 , 6 ,  4]])
        XCTAssertEqual(A.cofactor(0, 0), 56)
        XCTAssertEqual(A.cofactor(0, 1), 12)
        XCTAssertEqual(A.cofactor(0, 2), -46)
        XCTAssertEqual(A.determinant(), -196)
    }
    
    func testMatrixCanCalculateDeterminantFor4By4Matrix() {
        let A = Matrix([
            [-2 , -8 ,  3 ,  5],
            [-3 ,  1 ,  7 ,  3],
            [ 1 ,  2 , -9 ,  6],
            [-6 ,  7 ,  7 , -9]])
        XCTAssertEqual(A.cofactor(0, 0), 690)
        XCTAssertEqual(A.cofactor(0, 1), 447)
        XCTAssertEqual(A.cofactor(0, 2), 210)
        XCTAssertEqual(A.cofactor(0, 3), 51)
        XCTAssertEqual(A.determinant(), -4071)
    }
    
    func testMatrixCanTellIfItIsInvertible() {
        let A = Matrix([
            [6 ,  4 , 4 ,  4],
            [5 ,  5 , 7 ,  6],
            [4 , -9 , 3 , -7],
            [9 ,  1 , 7 , -6]])
        let B = Matrix([
            [-4 ,  2 , -2 , -3],
            [ 9 ,  6 ,  2 ,  6],
            [ 0 , -5 ,  1 , -5],
            [ 0 ,  0 ,  0 ,  0]])
        XCTAssertEqual(A.determinant(), -2120)
        XCTAssertTrue(A.isInvertible())
        XCTAssertEqual(B.determinant(), 0)
        XCTAssertFalse(B.isInvertible())
    }
    
    func testMatrixCanCalculateInverse() {
        let A = Matrix([
            [-5 ,  2 ,  6 , -8],
            [ 1 , -5 ,  1 ,  8],
            [ 7 ,  7 , -6 , -7],
            [ 1 , -3 ,  7 ,  4]])
        let B = A.inverted()
        XCTAssertEqual(A.determinant(), 532)
        XCTAssertEqual(A.cofactor(2, 3), -160)
        XCTAssertEqual(B[3 , 2], -160 / 532)
        XCTAssertEqual(A.cofactor(3, 2), 105)
        XCTAssertEqual(B[2, 3], 105 / 532)
        XCTAssertEqual(B, Matrix([
            [ 0.21805 ,  0.45113 ,  0.24060 , -0.04511],
            [-0.80827 , -1.45677 , -0.44361 ,  0.52068],
            [-0.07895 , -0.22368 , -0.05263 ,  0.19737],
            [-0.52256 , -0.81391 , -0.30075 ,  0.30639]]))

        XCTAssertEqual(
            Matrix([
                [ 8 , -5 ,  9 ,  2],
                [ 7 ,  5 ,  6 ,  1],
                [-6 ,  0 ,  9 ,  6],
                [-3 ,  0 , -9 , -4]]).inverted(),
            Matrix([
                [-0.15385 , -0.15385 , -0.28205 , -0.53846],
                [-0.07692 ,  0.12308 ,  0.02564 ,  0.03077],
                [ 0.35897 ,  0.35897 ,  0.43590 ,  0.92308],
                [-0.69231 , -0.69231 , -0.76923 , -1.92308]]))
        
        XCTAssertEqual(
            Matrix([
                [ 9 ,  3 ,  0 ,  9],
                [-5 , -2 , -6 , -3],
                [-4 ,  9 ,  6 ,  4],
                [-7 ,  6 ,  6 ,  2]]).inverted(),
            Matrix([
                [-0.04074 , -0.07778 ,  0.14444 , -0.22222],
                [-0.07778 ,  0.03333 ,  0.36667 , -0.33333],
                [-0.02901 , -0.14630 , -0.10926 ,  0.12963],
                [ 0.17778 ,  0.06667 , -0.26667 ,  0.33333]]))
    }
    
    func testMatrixProductMultipliedByInverseGivesOriginalMatrixAgain() {
        let A = Matrix([
            [ 3 , -9 ,  7 ,  3],
            [ 3 , -8 ,  2 , -9],
            [-4 ,  4 ,  4 ,  1],
            [-6 ,  5 , -1 ,  1]])
        let B = Matrix([
            [ 8 ,  2 ,  2 ,  2],
            [ 3 , -1 ,  7 ,  0],
            [ 7 ,  0 ,  5 ,  4],
            [ 6 , -2 ,  0 ,  5]])
        let C = A * B
        XCTAssertEqual(C * B.inverted(), A)
    }
}
