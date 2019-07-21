import XCTest
@testable import RayTracerChallengeModel

class PlaneTests: XCTestCase {
    func testPlaneHasIdentityMatrixAsDefaultTransformation() {
        let p = Plane()
        XCTAssertEqual(p.transform, identity())
    }

    func testPlanesTransformationCanBeChanged() {
        let t = identity().translated(2, 3, 4)
        let p = Plane(transform: t)
        XCTAssertEqual(p.transform, t)
    }

    func testPlaneHasDefaultMaterial() {
        let p = Plane()
        let m = p.material
        XCTAssertEqual(m, Material())
    }

    func testPlaneMaterialCanBeChanged() {
        let m = Material(ambient: 1)
        let p = Plane(material: m)
        XCTAssertEqual(p.material, m)
    }

    func testRayParallelToPlaneDoesNotLocalIntersect() {
        let p = Plane()
        let r = Ray(point(0, 10, 0), vector(0, 0, 1))
        let xs = p.localIntersect(r)
        XCTAssertEqual(xs.count, 0)
    }

    func testCoplanarRayDoesNotLocalIntersectPlane() {
        let p = Plane()
        let r = Ray(point(0, 0, 0), vector(0, 0, 1))
        let xs = p.localIntersect(r)
        XCTAssertEqual(xs.count, 0)
    }

    func testRayCanLocalIntersectPlaneFromAbove() {
        let p = Plane()
        let r = Ray(point(0, 1, 0), vector(0, -1, 0))
        let xs = p.localIntersect(r)
        XCTAssertEqual(xs.count, 1)
        XCTAssertEqual(xs[0].t, 1)
        XCTAssertEqual(xs[0].object as! Plane, p)
    }

    func testRayCanLocalIntersectPlaneFromBelow() {
        let p = Plane()
        let r = Ray(point(0, -1, 0), vector(0, 1, 0))
        let xs = p.localIntersect(r)
        XCTAssertEqual(xs.count, 1)
        XCTAssertEqual(xs[0].t, 1)
        XCTAssertEqual(xs[0].object as! Plane, p)
    }

    func testLocalNormalOfPlaneIsConstantEverywhere() {
        let p = Plane()
        let n1 = p.localNormalAt(point(0, 0, 0))
        let n2 = p.localNormalAt(point(10, 0, -10))
        let n3 = p.localNormalAt(point(-5, 0, 150))
        XCTAssertEqual(n1, vector(0, 1, 0))
        XCTAssertEqual(n2, vector(0, 1, 0))
        XCTAssertEqual(n3, vector(0, 1, 0))
    }
}
