import XCTest
@testable import RayTracerChallengeModel

class SphereTests: XCTestCase {
    func testRayCanIntersectSphereAtTwoPoints() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.intersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, 4.0)
        XCTAssertEqual(xs[1].t, 6.0)
    }
    
    func testRayCanIntersectSphereAtTangent() {
        let r = Ray(point(0, 1, -5), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.intersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, 5.0)
        XCTAssertEqual(xs[1].t, 5.0)
    }
    
    func testRayCanMissSphere() {
        let r = Ray(point(0, 2, -5), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.intersect(r)
        XCTAssertEqual(xs.count, 0)
    }
    
    func testRayCanIntersectSphereWhenOriginatedInsideSphere() {
        let r = Ray(point(0, 0, 0), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.intersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, -1.0)
        XCTAssertEqual(xs[1].t, 1.0)
    }
    
    func testRayCanIntersectSphereWhenSphereIsBehindRay() {
        let r = Ray(point(0, 0, 5), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.intersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, -6.0)
        XCTAssertEqual(xs[1].t, -4.0)
    }
    
    func testIntersectSetsSphereAsObjectOfIntersection() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.intersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].object as! Sphere, s)
        XCTAssertEqual(xs[1].object as! Sphere, s)
    }
}
