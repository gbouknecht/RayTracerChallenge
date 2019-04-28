import XCTest
@testable import RayTracerChallengeModel

class TransformationsTests: XCTestCase {
    func testViewTransformMatrixForDefaultOrientation() {
        let from = point(0, 0, 0)
        let to = point(0, 0, -1)
        let up = vector(0, 1, 0)
        let t = viewTransform(from: from, to: to, up: up)
        XCTAssertEqual(t, identity())
    }

    func testViewTransformMatrixForLookingInPositivezDirection() {
        let from = point(0, 0, 0)
        let to = point(0, 0, 1)
        let up = vector(0, 1, 0)
        let t = viewTransform(from: from, to: to, up: up)
        XCTAssertEqual(t, identity().scaled(-1, 1, -1))
    }

    func testViewTransformMatrixMovesTheWorld() {
        let from = point(0, 0, 8)
        let to = point(0, 0, 0)
        let up = vector(0, 1, 0)
        let t = viewTransform(from: from, to: to, up: up)
        XCTAssertEqual(t, identity().translated(0, 0, -8))
    }

    func testViewTransformMatrixWithArbitraryOrientation() {
        let from = point(1, 3, 2)
        let to = point(4, -2, 8)
        let up = vector(1, 1, 0)
        let t = viewTransform(from: from, to: to, up: up)
        XCTAssertEqual(t, Matrix([[-0.50709, 0.50709, 0.67612, -2.36643],
                                  [0.76772, 0.60609, 0.12122, -2.82843],
                                  [-0.35857, 0.59761, -0.71714, 0.00000],
                                  [0.00000, 0.00000, 0.00000, 1.00000]]))
    }
}
