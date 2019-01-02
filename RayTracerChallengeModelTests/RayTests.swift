import XCTest
@testable import RayTracerChallengeModel

class RayTests: XCTestCase {
    func testRayCanBeCreated() {
        let origin = point(1, 2, 3)
        let direction = vector(4, 5, 6)
        let r = Ray(origin, direction)
        XCTAssertEqual(r.origin, origin)
        XCTAssertEqual(r.direction, direction)
    }
    
    func testRayCanCalculatePointAtGivenDistance() {
        let r = Ray(point(2, 3, 4), vector(1, 0, 0))
        XCTAssertEqual(r.position(0), point(2, 3, 4))
        XCTAssertEqual(r.position(1), point(3, 3, 4))
        XCTAssertEqual(r.position(-1), point(1, 3, 4))
        XCTAssertEqual(r.position(2.5), point(4.5, 3, 4))
    }
    
    func testRayCanBeTransalted() {
        let r = Ray(point(1, 2, 3), vector(0, 1, 0))
        let m = identity().translated(3, 4, 5)
        let r2 = r.transformed(m)
        XCTAssertEqual(r2.origin, point(4, 6, 8))
        XCTAssertEqual(r2.direction, vector(0, 1, 0))
    }
    
    func testRayCanBeScaled() {
        let r = Ray(point(1, 2, 3), vector(0, 1, 0))
        let m = identity().scaled(2, 3, 4)
        let r2 = r.transformed(m)
        XCTAssertEqual(r2.origin, point(2, 6, 12))
        XCTAssertEqual(r2.direction, vector(0, 3, 0))
    }
}
