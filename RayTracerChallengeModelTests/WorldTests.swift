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
        XCTAssertTrue(w.objects.contains {
            $0 as! Sphere == s1
        })
        XCTAssertTrue(w.objects.contains {
            $0 as! Sphere == s2
        })
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

    func testWorldCanShadeAnIntersection() {
        let w = defaultWorld()
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let shape = w.objects[0]
        let i = Intersection(4, shape)
        let comps = PreparedComputations(intersection: i, ray: r)
        let c = w.shadeHit(comps)
        XCTAssertEqual(c, Color(0.38066, 0.47583, 0.2855))
    }

    func testWorldCanShadeAnIntersectionFromTheInside() {
        var w = defaultWorld()
        w.light = PointLight(point(0, 0.25, 0), .white)
        let r = Ray(point(0, 0, 0), vector(0, 0, 1))
        let shape = w.objects[1]
        let i = Intersection(0.5, shape)
        let comps = PreparedComputations(intersection: i, ray: r)
        let c = w.shadeHit(comps)
        XCTAssertEqual(c, Color(0.90498, 0.90498, 0.90498))
    }

    func testWorldCanShadeAnIntersectionInTheShadow() {
        let light = PointLight(point(0, 0, -10), .white)
        let s1 = Sphere()
        let s2 = Sphere(transform: identity().translated(0, 0, 10))
        let w = World(light: light, objects: [s1, s2])
        let r = Ray(point(0, 0, 5), vector(0, 0, 1))
        let i = Intersection(4, s2)
        let comps = PreparedComputations(intersection: i, ray: r)
        let c = w.shadeHit(comps)
        XCTAssertEqual(c, Color(0.1, 0.1, 0.1))
    }

    func testWorldCanDetermineColorWhenRayMisses() {
        let w = defaultWorld()
        let r = Ray(point(0, 0, -5), vector(0, 1, 0))
        let c = w.colorAt(r)
        XCTAssertEqual(c, .black)
    }

    func testWorldCanDetermineColorWhenRayHits() {
        let w = defaultWorld()
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let c = w.colorAt(r)
        XCTAssertEqual(c, Color(0.38066, 0.47583, 0.2855))
    }

    func testWorldCanDetermineColorAtIntersectionBehindRay() {
        var w = defaultWorld()
        w.objects[0].material.ambient = 1
        w.objects[1].material.ambient = 1
        let r = Ray(point(0, 0, 0.75), vector(0, 0, -1))
        let c = w.colorAt(r)
        XCTAssertEqual(c, w.objects[1].material.color)
    }

    func testWorldCanDetermineShadowWhenNothingIsCollinearWithPointAndLight() {
        let w = defaultWorld()
        let p = point(0, 10, 0)
        XCTAssertFalse(w.isShadowed(p))
    }

    func testWorldCanDetermineShadowWhenObjectIsBetweenPointAndLight() {
        let w = defaultWorld()
        let p = point(10, -10, 10)
        XCTAssertTrue(w.isShadowed(p))
    }

    func testWorldCanDetermineShadowWhenObjectIsBehindLight() {
        let w = defaultWorld()
        let p = point(-20, 20, -20)
        XCTAssertFalse(w.isShadowed(p))
    }

    func testWorldCanDetermineShadowWhenObjectIsBehindPoint() {
        let w = defaultWorld()
        let p = point(-2, 2, -2)
        XCTAssertFalse(w.isShadowed(p))
    }
}
