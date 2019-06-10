import XCTest
@testable import RayTracerChallengeModel

class SphereTests: XCTestCase {
    func testRayCanLocalIntersectSphereAtTwoPoints() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.localIntersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, 4.0)
        XCTAssertEqual(xs[1].t, 6.0)
    }
    
    func testRayCanLocalIntersectSphereAtTangent() {
        let r = Ray(point(0, 1, -5), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.localIntersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, 5.0)
        XCTAssertEqual(xs[1].t, 5.0)
    }
    
    func testRayCanMissSphere() {
        let r = Ray(point(0, 2, -5), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.localIntersect(r)
        XCTAssertEqual(xs.count, 0)
    }
    
    func testRayCanLocalIntersectSphereWhenOriginatedInsideSphere() {
        let r = Ray(point(0, 0, 0), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.localIntersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, -1.0)
        XCTAssertEqual(xs[1].t, 1.0)
    }
    
    func testRayCanLocalIntersectSphereWhenSphereIsBehindRay() {
        let r = Ray(point(0, 0, 5), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.localIntersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, -6.0)
        XCTAssertEqual(xs[1].t, -4.0)
    }
    
    func testLocalIntersectSetsSphereAsObjectOfIntersection() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let s = Sphere()
        let xs = s.localIntersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].object as! Sphere, s)
        XCTAssertEqual(xs[1].object as! Sphere, s)
    }
    
    func testSphereHasIdentityMatrixAsDefaultTransformation() {
        let s = Sphere()
        XCTAssertEqual(s.transform, identity())
    }
    
    func testSpheresTransformationCanBeChanged() {
        let t = identity().translated(2, 3, 4)
        let s = Sphere(transform: t)
        XCTAssertEqual(s.transform, t)
    }
    
    func testScaledSphereCanLocalIntersectRay() {
        let r = Ray(point(0, 0, -2.5), vector(0, 0, 0.5))
        let s = Sphere(transform: identity().scaled(2, 2, 2))
        let xs = s.localIntersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, 3)
        XCTAssertEqual(xs[1].t, 7)
    }
    
    func testTranslatedSphereCanLocalIntersectRay() {
        let r = Ray(point(-5, 0, -5), vector(0, 0, 1))
        let s = Sphere(transform: identity().translated(5, 0, 0))
        let xs = s.localIntersect(r)
        XCTAssertEqual(xs.count, 0)
    }
    
    func testSphereCanCalculateLocalNormalAtPointOnxAxis() {
        let s = Sphere()
        let n = s.localNormalAt(point(1, 0, 0))
        XCTAssertEqual(n, vector(1, 0, 0))
    }
    
    func testSphereCanCalculateLocalNormalAtPointOnyAxis() {
        let s = Sphere()
        let n = s.localNormalAt(point(0, 1, 0))
        XCTAssertEqual(n, vector(0, 1, 0))
    }
    
    func testSphereCanCalculateLocalNormalAtPointOnzAxis() {
        let s = Sphere()
        let n = s.localNormalAt(point(0, 0, 1))
        XCTAssertEqual(n, vector(0, 0, 1))
    }
    
    func testSphereCanCalculateLocalNormalAtNonAxialPoint() {
        let s = Sphere()
        let xyz = 3.0.squareRoot() / 3
        let n = s.localNormalAt(point(xyz, xyz, xyz))
        XCTAssertEqual(n, vector(xyz, xyz, xyz))
    }
    
    func testSphereHasDefaultMaterial() {
        let s = Sphere()
        let m = s.material
        XCTAssertEqual(m, Material())
    }
    
    func testSphereMaterialCanBeChanged() {
        let m = Material(ambient: 1)
        let s = Sphere(material: m)
        XCTAssertEqual(s.material, m)
    }
}
