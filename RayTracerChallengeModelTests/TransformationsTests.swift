import XCTest
@testable import RayTracerChallengeModel

class TransformationsTests: XCTestCase {
    func testTranslationMovesPoint() {
        let transform = translation(5, -3, 2)
        let p = point(-3, 4, 5)
        XCTAssertEqual(transform * p, point(2, 1, 7))
    }
    
    func testInvertedTranslationMovesPointInReverse() {
        let transform = translation(5, -3, 2)
        let inv = transform.inverted()
        let p = point(-3, 4, 5)
        XCTAssertEqual(inv * p, point(-8, 7, 3))
     }
    
    func testTranslationDoesNotMovesVector() {
        let transform = translation(5, -3, 2)
        let v = vector(-3, 4, 5)
        XCTAssertEqual(transform * v, v)
    }
    
    func testScalingMovesPointByMultiplication() {
        let transform = scaling(2, 3, 4)
        let p = point(-4, 6, 8)
        XCTAssertEqual(transform * p, point(-8, 18, 32))
    }
    
    func testScalingChangesVectorLength() {
        let transform = scaling(2, 3, 4)
        let v = vector(-4, 6, 8)
        XCTAssertEqual(transform * v, vector(-8, 18, 32))
    }
    
    func testInvertedScalingScalesTupleInOppositeWay() {
        let transform = scaling(2, 3, 4)
        let inv = transform.inverted()
        let v = vector(-4, 6, 8)
        XCTAssertEqual(inv * v, vector(-2, 2, 2))
    }
    
    func testScalingCanBeUsedToReflectAcrossAxis() {
        let transform = scaling(-1, 1, 1)
        let p = point(2, 3, 4)
        XCTAssertEqual(transform * p, point(-2, 3, 4))
    }
}
