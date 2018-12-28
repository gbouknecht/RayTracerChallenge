import XCTest
@testable import RayTracerChallengeModel

class CanvasToPPMConverterTests: XCTestCase {
    func testShouldConstructPPMHeaderAndPixels() {
        var c = Canvas(5, 3)
        let c1 = Color(1.5, 0, 0)
        let c2 = Color(0, 0.5, 0)
        let c3 = Color(-0.5, 0, 1)
        c[0, 0] = c1
        c[2, 1] = c2
        c[4, 2] = c3
        let ppm = CanvasToPPMConverter().ppm(from: c)
        XCTAssertEqual(ppm, """
                            P3
                            5 3
                            255
                            255 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                            0 0 0 0 0 0 0 128 0 0 0 0 0 0 0
                            0 0 0 0 0 0 0 0 0 0 0 0 0 0 255

                            """)
    }
    
    func testShouldSplitLongLinesInPPM() {
        var c = Canvas(15, 2)
        pairs(0..<c.width, 0..<c.height).forEach { (x, y) in
            c[x, y] = Color(1, 0.2, 0.6)
        }
        let ppm = CanvasToPPMConverter().ppm(from: c)
        XCTAssertEqual(ppm, """
                            P3
                            15 2
                            255
                            255 51 153 255 51 153 255 51 153 255 51 153 255 51 153 255 51 153 255
                            51 153 255 51 153 255 51 153 255 51 153 255 51 153 255 51 153 255 51
                            153 255 51 153 255 51 153
                            255 51 153 255 51 153 255 51 153 255 51 153 255 51 153 255 51 153 255
                            51 153 255 51 153 255 51 153 255 51 153 255 51 153 255 51 153 255 51
                            153 255 51 153 255 51 153

                            """)
    }
}
