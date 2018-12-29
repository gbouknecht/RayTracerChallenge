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
}
