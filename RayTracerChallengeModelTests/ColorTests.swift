import XCTest
@testable import RayTracerChallengeModel

class ColorTests: XCTestCase {
    func testColorShouldHasRedGreenAndBlueComponents() {
        let c = Color(-0.5, 0.4, 1.7)
        XCTAssertEqual(c.red, -0.5)
        XCTAssertEqual(c.green, 0.4)
        XCTAssertEqual(c.blue, 1.7)
    }
    
    func testColorEqualityShouldAllowSlightDifferences() {
        let c = Color(0.2, 0.3, 0.4)
        
        XCTAssertNotEqual(c, Color(0.199990, 0.3, 0.4))
        XCTAssertEqual   (c, Color(0.199991, 0.3, 0.4))
        XCTAssertEqual   (c, Color(0.200009, 0.3, 0.4))
        XCTAssertNotEqual(c, Color(0.200011, 0.3, 0.4))
        
        XCTAssertNotEqual(c, Color(0.2, 0.299990, 0.4))
        XCTAssertEqual   (c, Color(0.2, 0.299991, 0.4))
        XCTAssertEqual   (c, Color(0.2, 0.300009, 0.4))
        XCTAssertNotEqual(c, Color(0.2, 0.300010, 0.4))
        
        XCTAssertNotEqual(c, Color(0.2, 0.3, 0.399990))
        XCTAssertEqual   (c, Color(0.2, 0.3, 0.399991))
        XCTAssertEqual   (c, Color(0.2, 0.3, 0.400009))
        XCTAssertNotEqual(c, Color(0.2, 0.3, 0.400011))
    }
    
    func testColorsCanBeAdded() {
        let c1 = Color(0.9, 0.6, 0.75)
        let c2 = Color(0.7, 0.1, 0.25)
        XCTAssertEqual(c1 + c2, Color(1.6, 0.7, 1.0))
    }
    
    func testColorsCanBeSubtracted() {
        let c1 = Color(0.9, 0.6, 0.75)
        let c2 = Color(0.7, 0.1, 0.25)
        XCTAssertEqual(c1 - c2, Color(0.2, 0.5, 0.5))
    }
    
    func testColorCanBeMultipliedByScalar() {
        let c = Color(0.2, 0.3, 0.4)
        XCTAssertEqual(c * 2, Color(0.4, 0.6, 0.8))
    }
    
    func testColorsCanBeMultiplied() {
        let c1 = Color(1, 0.2, 0.4)
        let c2 = Color(0.9, 1, 0.1)
        XCTAssertEqual(c1 * c2, Color(0.9, 0.2, 0.04))
    }
}
