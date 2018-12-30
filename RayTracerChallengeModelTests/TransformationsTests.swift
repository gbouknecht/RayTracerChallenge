import XCTest
@testable import RayTracerChallengeModel

class TransformationsTests: XCTestCase {
    func testTranslationMovesPoint() {
        let transform = translation(5, -3, 2)
        let p = point(-3, 4, 5)
        XCTAssertEqual(transform * p, point(2, 1, 7))
    }
    
    func testInvertedTranslationMovesPointInReverse() {
        let transform = translation(5, -3, 2)
        let inv = transform.inverted()
        let p = point(-3, 4, 5)
        XCTAssertEqual(inv * p, point(-8, 7, 3))
     }
    
    func testTranslationDoesNotMovesVector() {
        let transform = translation(5, -3, 2)
        let v = vector(-3, 4, 5)
        XCTAssertEqual(transform * v, v)
    }
    
    func testScalingMovesPointByMultiplication() {
        let transform = scaling(2, 3, 4)
        let p = point(-4, 6, 8)
        XCTAssertEqual(transform * p, point(-8, 18, 32))
    }
    
    func testScalingChangesVectorLength() {
        let transform = scaling(2, 3, 4)
        let v = vector(-4, 6, 8)
        XCTAssertEqual(transform * v, vector(-8, 18, 32))
    }
    
    func testInvertedScalingScalesTupleInOppositeWay() {
        let transform = scaling(2, 3, 4)
        let inv = transform.inverted()
        let v = vector(-4, 6, 8)
        XCTAssertEqual(inv * v, vector(-2, 2, 2))
    }
    
    func testScalingCanBeUsedToReflectAcrossAxis() {
        let transform = scaling(-1, 1, 1)
        let p = point(2, 3, 4)
        XCTAssertEqual(transform * p, point(-2, 3, 4))
    }
    
    func testRotationCanRotatePointAroundxAxis() {
        let p = point(0, 1, 0)
        let halfQuarter = rotationx(.pi / 4)
        let fullQuarter = rotationx(.pi / 2)
        XCTAssertEqual(halfQuarter * p, point(0, 2.0.squareRoot() / 2, 2.0.squareRoot() / 2))
        XCTAssertEqual(halfQuarter * halfQuarter * p, point(0, 0, 1))
        XCTAssertEqual(fullQuarter * p, point(0, 0, 1))
    }
    
    func testInvertedRotationAroundxAxisRotatesInOppositeDirection() {
        let p = point(0, 1, 0)
        let halfQuarter = rotationx(.pi / 4)
        let inv = halfQuarter.inverted()
        XCTAssertEqual(inv * p, point(0, 2.0.squareRoot() / 2, -2.0.squareRoot() / 2))
    }
    
    func testRotationCanRotatePointAroundyAxis() {
        let p = point(0, 0, 1)
        let halfQuarter = rotationy(.pi / 4)
        let fullQuarter = rotationy(.pi / 2)
        XCTAssertEqual(halfQuarter * p, point(2.0.squareRoot() / 2, 0, 2.0.squareRoot() / 2))
        XCTAssertEqual(halfQuarter * halfQuarter * p, point(1, 0, 0))
        XCTAssertEqual(fullQuarter * p, point(1, 0, 0))
    }
    
    func testRotationCanRotatePointAroundzAxis() {
        let p = point(0, 1, 0)
        let halfQuarter = rotationz(.pi / 4)
        let fullQuarter = rotationz(.pi / 2)
        XCTAssertEqual(halfQuarter * p, point(-2.0.squareRoot() / 2, 2.0.squareRoot() / 2, 0))
        XCTAssertEqual(halfQuarter * halfQuarter * p, point(-1, 0, 0))
        XCTAssertEqual(fullQuarter * p, point(-1, 0, 0))
    }
    
    func testShearingMovesOneComponentOfPointInProportionToOtherComponents() {
        let p = point(2, 3, 4)
        XCTAssertEqual(shearing(xy: 1, xz: 0, yx: 0, yz: 0, zx: 0, zy: 0) * p, point(5, 3, 4))
        XCTAssertEqual(shearing(xy: 0, xz: 1, yx: 0, yz: 0, zx: 0, zy: 0) * p, point(6, 3, 4))
        XCTAssertEqual(shearing(xy: 0, xz: 0, yx: 1, yz: 0, zx: 0, zy: 0) * p, point(2, 5, 4))
        XCTAssertEqual(shearing(xy: 0, xz: 0, yx: 0, yz: 1, zx: 0, zy: 0) * p, point(2, 7, 4))
        XCTAssertEqual(shearing(xy: 0, xz: 0, yx: 0, yz: 0, zx: 1, zy: 0) * p, point(2, 3, 6))
        XCTAssertEqual(shearing(xy: 0, xz: 0, yx: 0, yz: 0, zx: 0, zy: 1) * p, point(2, 3, 7))
    }
}
