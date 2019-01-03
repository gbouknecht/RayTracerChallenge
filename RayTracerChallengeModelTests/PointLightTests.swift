import XCTest
@testable import RayTracerChallengeModel

class PointLightTests: XCTestCase {
    func testPointLightHasPositionAndIntensity() {
        let position = point(0, 0, 0)
        let intensity = Color.white
        let light = PointLight(position, intensity)
        XCTAssertEqual(light.position, position)
        XCTAssertEqual(light.intensity, intensity)
    }
}
