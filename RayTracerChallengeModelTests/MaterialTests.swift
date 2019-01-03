import XCTest
@testable import RayTracerChallengeModel

class MaterialTests: XCTestCase {
    func testMaterialHasDefaultValues() {
        let m = Material()
        XCTAssertEqual(m.color, Color(1, 1, 1))
        XCTAssertEqual(m.ambient, 0.1)
        XCTAssertEqual(m.diffuse, 0.9)
        XCTAssertEqual(m.specular, 0.9)
        XCTAssertEqual(m.shininess, 200.0)
    }
}
