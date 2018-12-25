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
    
    func testMatrixCanBeMultipliedByATuple() {
        let a = Matrix([
            [1 , 2 , 3 , 4],
            [2 , 4 , 4 , 2],
            [8 , 6 , 4 , 1],
            [0 , 0 , 0 , 1]])
        let b = Tuple(1, 2, 3, 1)
        XCTAssertEqual(a * b, Tuple(18, 24, 33, 1))
    }
}
