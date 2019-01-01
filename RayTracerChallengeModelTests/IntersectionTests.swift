import XCTest
@testable import RayTracerChallengeModel

class IntersectionTests: XCTestCase {
    func testIntersectionEncapsulatestAndObject() {
        let s = Sphere()
        let i = Intersection(3.5, s)
        XCTAssertEqual(i.t, 3.5)
        XCTAssertEqual(i.object as! Sphere, s)
    }
}
