import XCTest
@testable import RayTracerChallengeModel

class ColorTests: XCTestCase {
    func testColorShouldHasRedGreenAndBlueComponents() {
        let c = Color(-0.5, 0.4, 1.7)
        XCTAssertEqual(c.red, -0.5)
        XCTAssertEqual(c.green, 0.4)
        XCTAssertEqual(c.blue, 1.7)
    }
}
