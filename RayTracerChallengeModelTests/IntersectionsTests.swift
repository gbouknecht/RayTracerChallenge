import XCTest
@testable import RayTracerChallengeModel

class IntersectionsTests: XCTestCase {
    func testIntersectionsAggregateIntersections() {
        let s = Sphere()
        let i1 = Intersection(1, s)
        let i2 = Intersection(2, s)
        let xs = Intersections(i1, i2)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, 1)
        XCTAssertEqual(xs[1].t, 2)
    }
    
    func testIntersectionsHitShouldReturnIntersectionWithLowestt() {
        let s = Sphere()
        let i1 = Intersection(1, s)
        let i2 = Intersection(2, s)
        let xs = Intersections(i2, i1)
        let i = xs.hit()
        XCTAssertEqual(i!.t, 1)
    }
    
    func testIntersectionsHitShouldSkipNegativeIntersections() {
        let s = Sphere()
        let i1 = Intersection(-1, s)
        let i2 = Intersection(1, s)
        let xs = Intersections(i2, i1)
        let i = xs.hit()
        XCTAssertEqual(i!.t, 1)
    }
    
    func testIntersectionsHitShouldReturnNothingWhenAllIntersectionsAreNegative() {
        let s = Sphere()
        let i1 = Intersection(-2, s)
        let i2 = Intersection(-1, s)
        let xs = Intersections(i2, i1)
        let i = xs.hit()
        XCTAssertNil(i)
    }
    
    func testIntersectionsHitShouldAlwaysReturnLowestNonNegativeIntersection() {
        let s = Sphere()
        let i1 = Intersection(5, s)
        let i2 = Intersection(7, s)
        let i3 = Intersection(-3, s)
        let i4 = Intersection(2, s)
        let xs = Intersections(i1, i2, i3, i4)
        let i = xs.hit()
        XCTAssertEqual(i!.t, 2)
    }
}
