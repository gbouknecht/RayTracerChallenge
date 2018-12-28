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
        assertThatEveryPixelIsBlack(c)
    }
    
    func testCanvasPixelsCanBeWritten() {
        var c = Canvas(10, 20)
        let red = Color(1, 0, 0)
        c[2, 3] = red
        XCTAssertEqual(c[2, 3], red)
    }
    
    func testCanvasPixelsWrittenOutsideBoundsShouldBeIgnored() {
        var c = Canvas(10, 20)
        let red = Color(1, 0, 0)
        c[-1, 0] = red
        c[0, -1] = red
        c[10, 0] = red
        c[11, 0] = red
        c[0, 20] = red
        c[0, 21] = red
        assertThatEveryPixelIsBlack(c)
        c[0, 0] = red
        c[9, 19] = red
        XCTAssertEqual(c[0, 0], red)
        XCTAssertEqual(c[9, 19], red)
    }
    
    private func assertThatEveryPixelIsBlack(_ canvas: Canvas) {
        let black = Color(0, 0, 0)
        pairs(0..<canvas.width, 0..<canvas.height).forEach { (x, y) in
            XCTAssertEqual(canvas[x, y], black, "(\(x), \(y))")
        }
    }
}
