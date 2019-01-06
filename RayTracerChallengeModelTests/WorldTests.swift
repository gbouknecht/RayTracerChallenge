import XCTest
@testable import RayTracerChallengeModel

class WorldTests: XCTestCase {
    func testEmptyWorldCanBeCreated() {
        let w = World()
        XCTAssertNil(w.light)
        XCTAssertEqual(w.objects.count, 0)
    }
    
    func testThereExistsADefaultWorldForTesting() {
        let light = PointLight(point(-10, 10, -10), .white)
        let s1 = Sphere(material: Material(
            color: Color(0.8, 1.0, 0.6),
            diffuse: 0.7,
            specular: 0.2))
        let s2 = Sphere(transform: identity().scaled(0.5, 0.5, 0.5))
        let w = defaultWorld()
        XCTAssertEqual(w.light!, light)
        XCTAssertTrue(w.objects.contains { $0 as! Sphere == s1 })
        XCTAssertTrue(w.objects.contains { $0 as! Sphere == s2 })
    }
    
    func testWorldCanIntersectRay() {
        let w = defaultWorld()
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let xs = w.intersect(r)
        XCTAssertEqual(xs.count, 4)
        XCTAssertEqual(xs[0].t, 4)
        XCTAssertEqual(xs[1].t, 4.5)
        XCTAssertEqual(xs[2].t, 5.5)
        XCTAssertEqual(xs[3].t, 6)
    }
}
