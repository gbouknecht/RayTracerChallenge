import XCTest
@testable import RayTracerChallengeModel

class IntersectionsTests: XCTestCase {
    func testIntersectionsAggrateIntersections() {
        let s = Sphere()
        let i1 = Intersection(1, s)
        let i2 = Intersection(2, s)
        let xs = Intersections(i1, i2)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, 1)
        XCTAssertEqual(xs[1].t, 2)
    }
}
