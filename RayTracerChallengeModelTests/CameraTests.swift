import XCTest
@testable import RayTracerChallengeModel

class CameraTests: XCTestCase {
    func testCameraCanBeConstructed() {
        let hsize = 160
        let vsize = 120
        let fieldOfView = .pi / 2.0
        let c = Camera(hsize: hsize, vsize: vsize, fieldOfView: fieldOfView)
        XCTAssertEqual(c.hsize, 160)
        XCTAssertEqual(c.vsize, 120)
        XCTAssertEqual(c.fieldOfView, .pi / 2.0)
        XCTAssertEqual(c.transform, identity())
    }

    func testCameraCalculatesPixelSizeForHorizontalCanvasCorrectly() {
        let c = Camera(hsize: 200, vsize: 125, fieldOfView: .pi / 2.0)
        XCTAssertTrue(equal(c.pixelSize, 0.01))
    }

    func testCameraCalculatesPixelSizeForVerticalCanvasCorrectly() {
        let c = Camera(hsize: 125, vsize: 200, fieldOfView: .pi / 2.0)
        XCTAssertTrue(equal(c.pixelSize, 0.01))
    }

    func testCameraCanConstructRayThroughCenterOfCanvas() {
        let c = Camera(hsize: 201, vsize: 101, fieldOfView: .pi / 2.0)
        let r = c.rayForPixel(100, 50)
        XCTAssertEqual(r.origin, point(0, 0, 0))
        XCTAssertEqual(r.direction, vector(0, 0, -1))
    }

    func testCameraCanConstructRayThroughCornerOfCanvas() {
        let c = Camera(hsize: 201, vsize: 101, fieldOfView: .pi / 2.0)
        let r = c.rayForPixel(0, 0)
        XCTAssertEqual(r.origin, point(0, 0, 0))
        XCTAssertEqual(r.direction, vector(0.66519, 0.33259, -0.66851))
    }

    func testCameraCanConstructRayWhenCameraIsTransformed() {
        var c = Camera(hsize: 201, vsize: 101, fieldOfView: .pi / 2.0)
        c.transform = identity().translated(0, -2, 5).rotatedAroundy(.pi / 4.0)
        let r = c.rayForPixel(100, 50)
        XCTAssertEqual(r.origin, point(0, 2, -5))
        XCTAssertEqual(r.direction, vector(2.0.squareRoot() / 2, 0, -2.0.squareRoot() / 2))
    }

    func testCameraCanRenderWorld() {
        let w = defaultWorld()
        var c = Camera(hsize: 11, vsize: 11, fieldOfView: .pi / 2.0)
        let from = point(0, 0, -5)
        let to = point(0, 0, 0)
        let up = vector(0, 1, 0)
        c.transform = viewTransform(from: from, to: to, up: up)
        let image = c.render(w)
        XCTAssertEqual(image[5, 5], Color(0.38066, 0.47583, 0.2855))
    }
}
