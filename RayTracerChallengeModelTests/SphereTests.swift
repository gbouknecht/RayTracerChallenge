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
    
    func testSphereHasIdentityMatrixAsDefaultTransformation() {
        let s = Sphere()
        XCTAssertEqual(s.transform, identity())
    }
    
    func testSpheresTransformationCanBeChanged() {
        let t = identity().translated(2, 3, 4)
        let s = Sphere(transform: t)
        XCTAssertEqual(s.transform, t)
    }
    
    func testScaledSphereCanIntersectRay() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let s = Sphere(transform: identity().scaled(2, 2, 2))
        let xs = s.intersect(r)
        XCTAssertEqual(xs.count, 2)
        XCTAssertEqual(xs[0].t, 3)
        XCTAssertEqual(xs[1].t, 7)
    }
    
    func testTranslatedSphereCanIntersectRay() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let s = Sphere(transform: identity().translated(5, 0, 0))
        let xs = s.intersect(r)
        XCTAssertEqual(xs.count, 0)
    }
    
    func testSphereCanCalculateNormalAtPointOnxAxis() {
        let s = Sphere()
        let n = s.normalAt(point(1, 0, 0))
        XCTAssertEqual(n, vector(1, 0, 0))
    }
    
    func testSphereCanCalculateNormalAtPointOnyAxis() {
        let s = Sphere()
        let n = s.normalAt(point(0, 1, 0))
        XCTAssertEqual(n, vector(0, 1, 0))
    }
    
    func testSphereCanCalculateNormalAtPointOnzAxis() {
        let s = Sphere()
        let n = s.normalAt(point(0, 0, 1))
        XCTAssertEqual(n, vector(0, 0, 1))
    }
    
    func testSphereCanCalculateNormalAtNonAxialPoint() {
        let s = Sphere()
        let xyz = 3.0.squareRoot() / 3
        let n = s.normalAt(point(xyz, xyz, xyz))
        XCTAssertEqual(n, vector(xyz, xyz, xyz))
    }
    
    func testSphereCalculatedNormalIsNormalized() {
        let s = Sphere()
        let xyz = 3.0.squareRoot() / 3
        let n = s.normalAt(point(xyz, xyz, xyz))
        XCTAssertEqual(n, n.normalized())
    }
    
    func testSphereCanCalculateNormalWhenTranslated() {
        let s = Sphere(transform: identity().translated(0, 1, 0))
        let n = s.normalAt(point(0, 1.70711, -0.70711))
        XCTAssertEqual(n, vector(0, 0.70711, -0.70711))
    }
    
    func testSphereCanCalculateNormalWhenTransformed() {
        let s = Sphere(transform: identity().rotatedAroundz(.pi / 5).scaled(1, 0.5, 1))
        let n = s.normalAt(point(0, 2.0.squareRoot() / 2, -2.0.squareRoot() / 2))
        XCTAssertEqual(n, vector(0, 0.97014, -0.24254))
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
