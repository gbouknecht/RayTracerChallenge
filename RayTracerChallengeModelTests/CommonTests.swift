import XCTest
@testable import RayTracerChallengeModel

class CommonTests: XCTestCase {
    func testDoubleEqualityShouldAllowSlightDifferences() {
        XCTAssertFalse(equal(1.0, 0.999989))
        XCTAssertTrue (equal(1.0, 0.999991))
        XCTAssertTrue (equal(1.0, 1.000009))
        XCTAssertFalse(equal(1.0, 1.000010))
    }
}
