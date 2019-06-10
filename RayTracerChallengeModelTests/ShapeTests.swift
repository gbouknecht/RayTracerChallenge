import XCTest
@testable import RayTracerChallengeModel

class ShapeTests: XCTestCase {
    func testScaledShapeCanIntersectRay() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let s = TestShape(transform: identity().scaled(2, 2, 2))
        _ = s.intersect(r)
        XCTAssertEqual(s.saved.ray?.origin, point(0, 0, -2.5))
        XCTAssertEqual(s.saved.ray?.direction, vector(0, 0, 0.5))
    }

    func testTranslatedShapeCanIntersectRay() {
        let r = Ray(point(0, 0, -5), vector(0, 0, 1))
        let s = TestShape(transform: identity().translated(5, 0, 0))
        _ = s.intersect(r)
        XCTAssertEqual(s.saved.ray?.origin, point(-5, 0, -5))
        XCTAssertEqual(s.saved.ray?.direction, vector(0, 0, 1))
    }

    func testShapeCalculatedNormalIsNormalized() {
        let s = TestShape()
        let xyz = 3.0.squareRoot()
        let n = s.normalAt(point(xyz, xyz, xyz))
        XCTAssertEqual(n, n.normalized())
    }

    func testShapeCanCalculateNormalWhenTranslated() {
        let s = TestShape(transform: identity().translated(0, 1, 0))
        let n = s.normalAt(point(0, 1.70711, -0.70711))
        XCTAssertEqual(n, vector(0, 0.70711, -0.70711))
    }

    func testShapeCanCalculateNormalWhenTransformed() {
        let s = TestShape(transform: identity().rotatedAroundz(.pi / 5).scaled(1, 0.5, 1))
        let n = s.normalAt(point(0, 2.0.squareRoot() / 2, -2.0.squareRoot() / 2))
        XCTAssertEqual(n, vector(0, 0.97014, -0.24254))
    }
}

fileprivate struct TestShape: Shape {
    let transform: Matrix
    var material: Material

    let saved = Saved()

    init(transform: Matrix = identity(), material: Material = Material()) {
        self.transform = transform
        self.material = material
    }

    func localIntersect(_ localRay: Ray) -> Intersections {
        saved.ray = localRay
        return Intersections()
    }

    func localNormalAt(_ localPoint: Tuple) -> Tuple {
        return localPoint - point(0, 0, 0)
    }

    class Saved {
        var ray: Ray?
    }
}
