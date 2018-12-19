import XCTest
@testable import RayTracerChallenge

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
}
