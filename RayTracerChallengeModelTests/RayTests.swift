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
}
