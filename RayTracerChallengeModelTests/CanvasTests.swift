import XCTest
@testable import RayTracerChallengeModel

class CanvasTests: XCTestCase {
    func testCanvasCanBeCreatedWithGivenWidthAndHeight() {
        let c = Canvas(10, 20)
        XCTAssertEqual(c.width, 10)
        XCTAssertEqual(c.height, 20)
    }

    func testCanvasShouldBeInitializedWithEveryPixelBlack() {
        let c = Canvas(10, 20)
        for x in 0..<c.width {
            for y in 0..<c.height {
                XCTAssertEqual(c[x, y], Color(0, 0, 0))
            }
        }
    }
    
    func testCanvasPixelsCanBeWritten() {
        var c = Canvas(10, 20)
        let red = Color(1, 0, 0)
        c[2, 3] = red
        XCTAssertEqual(c[2, 3], red)
    }
}
