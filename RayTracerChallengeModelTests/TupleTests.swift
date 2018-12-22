import XCTest
@testable import RayTracerChallengeModel

class TupleTests: XCTestCase {
    func testTupleWithwOneShouldBeSeenAsAPoint() {
        let tuple = Tuple(4.3, -4.2, 3.1, 1.0)
        XCTAssertEqual(4.3, tuple.x)
        XCTAssertEqual(-4.2, tuple.y)
        XCTAssertEqual(3.1, tuple.z)
        XCTAssertEqual(1.0, tuple.w)
        XCTAssertTrue(tuple.isPoint())
        XCTAssertFalse(tuple.isVector())
    }

    func testTupleWithwZeroShouldBeSeenAsAVector() {
        let tuple = Tuple(4.3, -4.2, 3.1, 0.0)
        XCTAssertEqual(4.3, tuple.x)
        XCTAssertEqual(-4.2, tuple.y)
        XCTAssertEqual(3.1, tuple.z)
        XCTAssertEqual(0.0, tuple.w)
        XCTAssertFalse(tuple.isPoint())
        XCTAssertTrue(tuple.isVector())
    }
    
    func testTupleFromPointShouldCreateTupleWithwOne() {
        let point = Tuple(fromPoint: 4, -4, 3)
        XCTAssertEqual(point, Tuple(4, -4, 3, 1.0))
    }
    
    func testTupleFromVectorShouldCreateTupleWithwZero() {
        let vector = Tuple(fromVector: 4, -4, 3)
        XCTAssertEqual(vector, Tuple(4, -4, 3, 0.0))
    }
    
    func testTupleEqualityShouldAllowSlightDifferences() {
        let tuple = Tuple(2.0, 3.0, 4.0, 1.0)
        
        XCTAssertNotEqual(tuple, Tuple(1.999990, 3.0, 4.0, 1.0))
        XCTAssertEqual   (tuple, Tuple(1.999991, 3.0, 4.0, 1.0))
        XCTAssertEqual   (tuple, Tuple(2.000009, 3.0, 4.0, 1.0))
        XCTAssertNotEqual(tuple, Tuple(2.000010, 3.0, 4.0, 1.0))
        
        XCTAssertNotEqual(tuple, Tuple(2.0, 2.999990, 4.0, 1.0))
        XCTAssertEqual   (tuple, Tuple(2.0, 2.999991, 4.0, 1.0))
        XCTAssertEqual   (tuple, Tuple(2.0, 3.000009, 4.0, 1.0))
        XCTAssertNotEqual(tuple, Tuple(2.0, 3.000010, 4.0, 1.0))
        
        XCTAssertNotEqual(tuple, Tuple(2.0, 3.0, 3.999990, 1.0))
        XCTAssertEqual   (tuple, Tuple(2.0, 3.0, 3.999991, 1.0))
        XCTAssertEqual   (tuple, Tuple(2.0, 3.0, 4.000009, 1.0))
        XCTAssertNotEqual(tuple, Tuple(2.0, 3.0, 4.000011, 1.0))
        
        XCTAssertNotEqual(tuple, Tuple(2.0, 3.0, 4.0, 0.999989))
        XCTAssertEqual   (tuple, Tuple(2.0, 3.0, 4.0, 0.999991))
        XCTAssertEqual   (tuple, Tuple(2.0, 3.0, 4.0, 1.000009))
        XCTAssertNotEqual(tuple, Tuple(2.0, 3.0, 4.0, 1.000010))
    }
    
    func testTuplesCanBeAdded() {
        let a1 = Tuple(3, -2, 5, 1)
        let a2 = Tuple(-2, 3, 1, 0)
        XCTAssertEqual(a1 + a2, Tuple(1, 1, 6, 1))
    }
    
    func testPointsCanBeSubtracted() {
        let p1 = Tuple(fromPoint: 3, 2, 1)
        let p2 = Tuple(fromPoint: 5, 6, 7)
        XCTAssertEqual(p1 - p2, Tuple(fromVector: -2, -4, -6))
    }
    
    func testVectorCanBeSubtractedFromPoint() {
        let p = Tuple(fromPoint: 3, 2, 1)
        let v = Tuple(fromVector: 5, 6, 7)
        XCTAssertEqual(p - v, Tuple(fromPoint: -2, -4, -6))
    }
    
    func testVectorsCanBeSubtracted() {
        let v1 = Tuple(fromVector: 3, 2, 1)
        let v2 = Tuple(fromVector: 5, 6, 7)
        XCTAssertEqual(v1 - v2, Tuple(fromVector: -2, -4, -6))
    }
    
    func testVectorCanBeSubtractedFromZeroVector() {
        let zero = Tuple(fromVector: 0, 0, 0)
        let v = Tuple(fromVector: 1, -2, 3)
        XCTAssertEqual(zero - v, Tuple(fromVector: -1, 2, -3))
    }
    
    func testTupleCanBeNegated() {
        let a = Tuple(1, -2, 3, -4)
        XCTAssertEqual(-a, Tuple(-1, 2, -3, 4))
    }
    
    func testTupleCanBeMultipliedByAScalar() {
        let a = Tuple(1, -2, 3, -4)
        XCTAssertEqual(a * 3.5, Tuple(3.5, -7, 10.5, -14))
    }
    
    func testTupleCanBeMultipliedByAFraction() {
        let a = Tuple(1, -2, 3, -4)
        XCTAssertEqual(a * 0.5, Tuple(0.5, -1, 1.5, -2))
    }
    
    func testTupleCanBeDividedByAScalar() {
        let a = Tuple(1, -2, 3, -4)
        XCTAssertEqual(a / 2, Tuple(0.5, -1, 1.5, -2))
    }
    
    func testVectorHasAMagnitude() {
        XCTAssertEqual(Tuple(fromVector: 1, 0, 0).magnitude, 1)
        XCTAssertEqual(Tuple(fromVector: 0, 1, 0).magnitude, 1)
        XCTAssertEqual(Tuple(fromVector: 0, 0, 1).magnitude, 1)
        XCTAssertEqual(Tuple(fromVector: 1, 2, 3).magnitude, 14.squareRoot())
        XCTAssertEqual(Tuple(fromVector: -1, -2, -3).magnitude, 14.squareRoot())
    }
    
    func testVectorCanBeNormalized() {
        XCTAssertEqual(Tuple(fromVector: 4, 0, 0).normalized(), Tuple(fromVector: 1, 0, 0))
        XCTAssertEqual(Tuple(fromVector: 1, 2, 3).normalized(), Tuple(fromVector: 0.26726, 0.53452, 0.80178))
    }
    
    func testNormalizedVectorShouldHasMagnitudeOne() {
        let v = Tuple(fromVector: 1, 2, 3)
        let norm = v.normalized()
        XCTAssertEqual(norm.magnitude, 1)
    }
    
    func testVectorCanCalculateDotProduct() {
        let a = Tuple(fromVector: 1, 2, 3)
        let b = Tuple(fromVector: 2, 3, 4)
        XCTAssertEqual(a.dot(b), 20)
    }
    
    func testVectorCanCalculateCrossProduct() {
        let a = Tuple(fromVector: 1, 2, 3)
        let b = Tuple(fromVector: 2, 3, 4)
        XCTAssertEqual(a.cross(b), Tuple(fromVector: -1, 2, -1))
        XCTAssertEqual(b.cross(a), Tuple(fromVector: 1, -2, 1))
    }
}