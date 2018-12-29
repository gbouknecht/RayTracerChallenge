import XCTest
@testable import RayTracerChallengeModel

class TransformationsTests: XCTestCase {
    func testTranslationMovesPoint() {
        let transform = translation(5, -3, 2)
        let p = Tuple(fromPoint: -3, 4, 5)
        XCTAssertEqual(transform * p, Tuple(fromPoint: 2, 1, 7))
    }
    
    func testInvertedTranslationMovesPointInReverse() {
        let transform = translation(5, -3, 2)
        let inv = transform.inverted()
        let p = Tuple(fromPoint: -3, 4, 5)
        XCTAssertEqual(inv * p, Tuple(fromPoint: -8, 7, 3))
     }
    
    func testTranslationDoesNotMovesVector() {
        let transform = translation(5, -3, 2)
        let v = Tuple(fromVector: -3, 4, 5)
        XCTAssertEqual(transform * v, v)
    }
    
    func testScalingMovesPointByMultiplication() {
        let transform = scaling(2, 3, 4)
        let p = Tuple(fromPoint: -4, 6, 8)
        XCTAssertEqual(transform * p, Tuple(fromPoint: -8, 18, 32))
    }
    
    func testScalingChangesVectorLength() {
        let transform = scaling(2, 3, 4)
        let v = Tuple(fromVector: -4, 6, 8)
        XCTAssertEqual(transform * v, Tuple(fromVector: -8, 18, 32))
    }
    
    func testInvertedScalingScalesTupleInOppositeWay() {
        let transform = scaling(2, 3, 4)
        let inv = transform.inverted()
        let v = Tuple(fromVector: -4, 6, 8)
        XCTAssertEqual(inv * v, Tuple(fromVector: -2, 2, 2))
    }
    
    func testScalingCanBeUsedToReflectAcrossAxis() {
        let transform = scaling(-1, 1, 1)
        let p = Tuple(fromPoint: 2, 3, 4)
        XCTAssertEqual(transform * p, Tuple(fromPoint: -2, 3, 4))
    }
}
