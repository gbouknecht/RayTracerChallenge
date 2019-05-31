import XCTest
@testable import RayTracerChallengeModel

class PreparedComputationsTests: XCTestCase {
    func testPreparedComputationsPrecomputesStateOfIntersection() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let shape = Sphere()
        let i = Intersection(4, shape)
        let comps = PreparedComputations(intersection: i, ray: r)
        XCTAssertEqual(comps.t, i.t)
        XCTAssertEqual(comps.object as! Sphere, i.object as! Sphere)
        XCTAssertEqual(comps.point, point(0, 0, -1))
        XCTAssertEqual(comps.eyev, vector(0, 0, -1))
        XCTAssertEqual(comps.normalv, vector(0, 0, -1))
    }

    func testPreparedComputationsDetectsIfIntersectionOccursOnTheOutside() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let shape = Sphere()
        let i = Intersection(4, shape)
        let comps = PreparedComputations(intersection: i, ray: r)
        XCTAssertFalse(comps.inside)
    }

    func testPreparedComputationsDetectsIfIntersectionOccursOnTheInside() {
        let r = Ray(point(0, 0, 0), vector(0, 0, 1))
        let shape = Sphere()
        let i = Intersection(1, shape)
        let comps = PreparedComputations(intersection: i, ray: r)
        XCTAssertEqual(comps.point, point(0, 0, 1))
        XCTAssertEqual(comps.eyev, vector(0, 0, -1))
        XCTAssertTrue(comps.inside)
        XCTAssertEqual(comps.normalv, vector(0, 0, -1))
    }

    func testPreparedComputationsCalculatesOverPoint() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let shape = Sphere(transform: identity().translated(0, 0, 1))
        let i = Intersection(5, shape)
        let comps = PreparedComputations(intersection: i, ray: r)
        XCTAssertTrue(comps.overPoint.z < -epsilon / 2)
        XCTAssertTrue(comps.point.z > comps.overPoint.z)
    }
}
