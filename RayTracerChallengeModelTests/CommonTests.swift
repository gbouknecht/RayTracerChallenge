import XCTest
@testable import RayTracerChallengeModel

class CommonTests: XCTestCase {
    func testDoubleEqualityShouldAllowSlightDifferences() {
        XCTAssertFalse(equal(1.0, 0.999989))
        XCTAssertTrue (equal(1.0, 0.999991))
        XCTAssertTrue (equal(1.0, 1.000009))
        XCTAssertFalse(equal(1.0, 1.000010))
    }
    
    func testPairsShouldGiveArrayOf2TuplesIteratedOverBothArguments() {
        XCTAssertEqual(pairs(0..<2, 1..<4).map { [$0.0, $0.1] }, [[0, 1], [0, 2], [0, 3], [1, 1], [1, 2], [1, 3]])
        XCTAssertEqual(pairs(-1...1, -1...1).map { [$0.0, $0.1] }, [
            [-1, -1], [-1, 0], [-1, 1],
            [ 0, -1], [ 0, 0], [ 0, 1],
            [ 1, -1], [ 1, 0], [ 1, 1]])
    }
}
