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
    
    func testPointFunctionShouldCreateTupleWithwOne() {
        XCTAssertEqual(point(4, -4, 3), Tuple(4, -4, 3, 1.0))
    }
    
    func testTupleFromVectorShouldCreateTupleWithwZero() {
        let vector = Tuple(fromVector: 4, -4, 3)
        XCTAssertEqual(vector, Tuple(4, -4, 3, 0.0))
    }
    
    func testVectorFunctionShouldCreateTupleWithwZero() {
        XCTAssertEqual(vector(4, -4, 3), Tuple(4, -4, 3, 0.0))
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
        let p1 = point(3, 2, 1)
        let p2 = point(5, 6, 7)
        XCTAssertEqual(p1 - p2, vector(-2, -4, -6))
    }
    
    func testVectorCanBeSubtractedFromPoint() {
        let p = point(3, 2, 1)
        let v = vector(5, 6, 7)
        XCTAssertEqual(p - v, point(-2, -4, -6))
    }
    
    func testVectorsCanBeSubtracted() {
        let v1 = vector(3, 2, 1)
        let v2 = vector(5, 6, 7)
        XCTAssertEqual(v1 - v2, vector(-2, -4, -6))
    }
    
    func testVectorCanBeSubtractedFromZeroVector() {
        let zero = vector(0, 0, 0)
        let v = vector(1, -2, 3)
        XCTAssertEqual(zero - v, vector(-1, 2, -3))
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
        XCTAssertEqual(vector(1, 0, 0).magnitude, 1)
        XCTAssertEqual(vector(0, 1, 0).magnitude, 1)
        XCTAssertEqual(vector(0, 0, 1).magnitude, 1)
        XCTAssertEqual(vector(1, 2, 3).magnitude, 14.squareRoot())
        XCTAssertEqual(vector(-1, -2, -3).magnitude, 14.squareRoot())
    }
    
    func testVectorCanBeNormalized() {
        XCTAssertEqual(vector(4, 0, 0).normalized(), vector(1, 0, 0))
        XCTAssertEqual(vector(1, 2, 3).normalized(), vector(0.26726, 0.53452, 0.80178))
    }
    
    func testNormalizedVectorShouldHasMagnitudeOne() {
        let v = vector(1, 2, 3)
        let norm = v.normalized()
        XCTAssertEqual(norm.magnitude, 1)
    }
    
    func testVectorCanCalculateDotProduct() {
        let a = vector(1, 2, 3)
        let b = vector(2, 3, 4)
        XCTAssertEqual(a.dot(b), 20)
    }
    
    func testVectorCanCalculateCrossProduct() {
        let a = vector(1, 2, 3)
        let b = vector(2, 3, 4)
        XCTAssertEqual(a.cross(b), vector(-1, 2, -1))
        XCTAssertEqual(b.cross(a), vector(1, -2, 1))
    }
    
    func testVectorCanCalculateReflectionWhenApproachingAt45Degrees() {
        let v = vector(1, -1, 0)
        let n = vector(0, 1, 0)
        let r = v.reflected(n)
        XCTAssertEqual(r, vector(1, 1, 0))
    }
    
    func testVectorCanCalculateReflectionWhenHittingSlantedSurface() {
        let v = vector(0, -1, 0)
        let n = vector(2.0.squareRoot() / 2, 2.0.squareRoot() / 2, 0)
        let r = v.reflected(n)
        XCTAssertEqual(r, vector(1, 0, 0))
    }
}
