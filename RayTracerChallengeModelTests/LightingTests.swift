import XCTest
@testable import RayTracerChallengeModel

class LightingTests: XCTestCase {
    let m = Material()
    let position = point(0, 0, 0)
    
    func testLightingWithEyeBetweenLightAndSurface() {
        let eyev = vector(0, 0, -1)
        let normalv = vector(0, 0, -1)
        let light = PointLight(point(0, 0, -10), .white)
        let result = lighting(material: m, light: light, point: position, eyev: eyev, normalv: normalv, inShadow: false)
        XCTAssertEqual(result, Color(1.9, 1.9, 1.9))
    }
    
    func testLightingWithEyeBetweenLightAndSurfaceAndEyeOffset45Degrees() {
        let eyev = vector(0, 2.0.squareRoot() / 2, -2.0.squareRoot() / 2)
        let normalv = vector(0, 0, -1)
        let light = PointLight(point(0, 0, -10), .white)
        let result = lighting(material: m, light: light, point: position, eyev: eyev, normalv: normalv, inShadow: false)
        XCTAssertEqual(result, Color(1.0, 1.0, 1.0))
    }
    
    func testLightingWithEyeOppositeSurfaceAndLightOffset45Degrees() {
        let eyev = vector(0, 0, -1)
        let normalv = vector(0, 0, -1)
        let light = PointLight(point(0, 10, -10), .white)
        let result = lighting(material: m, light: light, point: position, eyev: eyev, normalv: normalv, inShadow: false)
        XCTAssertEqual(result, Color(0.7364, 0.7364, 0.7364))
    }
    
    func testLightingWithEyeInPathReflectionVector() {
        let eyev = vector(0, -2.0.squareRoot() / 2, -2.0.squareRoot() / 2)
        let normalv = vector(0, 0, -1)
        let light = PointLight(point(0, 10, -10), .white)
        let result = lighting(material: m, light: light, point: position, eyev: eyev, normalv: normalv, inShadow: false)
        XCTAssertEqual(result, Color(1.6364, 1.6364, 1.6364))
    }
    
    func testLightingWithLightBehindSurface() {
        let eyev = vector(0, 0, -1)
        let normalv = vector(0, 0, -1)
        let light = PointLight(point(0, 0, 10), .white)
        let result = lighting(material: m, light: light, point: position, eyev: eyev, normalv: normalv, inShadow: false)
        XCTAssertEqual(result, Color(0.1, 0.1, 0.1))
    }

    func testLightingWithSurfaceInShadow() {
        let eyev = vector(0, 0, -1)
        let normalv = vector(0, 0, -1)
        let light = PointLight(point(0, 0, -10), .white)
        let inShadow = true
        let result = lighting(material: m, light: light, point: position, eyev: eyev, normalv: normalv, inShadow: inShadow)
        XCTAssertEqual(result, Color(0.1, 0.1, 0.1))
    }
}
