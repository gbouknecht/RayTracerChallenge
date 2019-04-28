import XCTest
@testable import RayTracerChallengeModel

class MatrixTransformationsTests: XCTestCase {
    func testTranslationMovesPoint() {
        let transform = identity().translated(5, -3, 2)
        let p = point(-3, 4, 5)
        XCTAssertEqual(transform * p, point(2, 1, 7))
    }
    
    func testInvertedTranslationMovesPointInReverse() {
        let transform = identity().translated(5, -3, 2)
        let inv = transform.inverted()
        let p = point(-3, 4, 5)
        XCTAssertEqual(inv * p, point(-8, 7, 3))
     }
    
    func testTranslationDoesNotMovesVector() {
        let transform = identity().translated(5, -3, 2)
        let v = vector(-3, 4, 5)
        XCTAssertEqual(transform * v, v)
    }
    
    func testScalingMovesPointByMultiplication() {
        let transform = identity().scaled(2, 3, 4)
        let p = point(-4, 6, 8)
        XCTAssertEqual(transform * p, point(-8, 18, 32))
    }
    
    func testScalingChangesVectorLength() {
        let transform = identity().scaled(2, 3, 4)
        let v = vector(-4, 6, 8)
        XCTAssertEqual(transform * v, vector(-8, 18, 32))
    }
    
    func testInvertedScalingScalesTupleInOppositeWay() {
        let transform = identity().scaled(2, 3, 4)
        let inv = transform.inverted()
        let v = vector(-4, 6, 8)
        XCTAssertEqual(inv * v, vector(-2, 2, 2))
    }
    
    func testScalingCanBeUsedToReflectAcrossAxis() {
        let transform = identity().scaled(-1, 1, 1)
        let p = point(2, 3, 4)
        XCTAssertEqual(transform * p, point(-2, 3, 4))
    }
    
    func testRotationCanRotatePointAroundxAxis() {
        let p = point(0, 1, 0)
        let halfQuarter = identity().rotatedAroundx(.pi / 4)
        let fullQuarter = identity().rotatedAroundx(.pi / 2)
        XCTAssertEqual(halfQuarter * p, point(0, 2.0.squareRoot() / 2, 2.0.squareRoot() / 2))
        XCTAssertEqual(halfQuarter * halfQuarter * p, point(0, 0, 1))
        XCTAssertEqual(fullQuarter * p, point(0, 0, 1))
    }
    
    func testInvertedRotationAroundxAxisRotatesInOppositeDirection() {
        let p = point(0, 1, 0)
        let halfQuarter = identity().rotatedAroundx(.pi / 4)
        let inv = halfQuarter.inverted()
        XCTAssertEqual(inv * p, point(0, 2.0.squareRoot() / 2, -2.0.squareRoot() / 2))
    }
    
    func testRotationCanRotatePointAroundyAxis() {
        let p = point(0, 0, 1)
        let halfQuarter = identity().rotatedAroundy(.pi / 4)
        let fullQuarter = identity().rotatedAroundy(.pi / 2)
        XCTAssertEqual(halfQuarter * p, point(2.0.squareRoot() / 2, 0, 2.0.squareRoot() / 2))
        XCTAssertEqual(halfQuarter * halfQuarter * p, point(1, 0, 0))
        XCTAssertEqual(fullQuarter * p, point(1, 0, 0))
    }
    
    func testRotationCanRotatePointAroundzAxis() {
        let p = point(0, 1, 0)
        let halfQuarter = identity().rotatedAroundz(.pi / 4)
        let fullQuarter = identity().rotatedAroundz(.pi / 2)
        XCTAssertEqual(halfQuarter * p, point(-2.0.squareRoot() / 2, 2.0.squareRoot() / 2, 0))
        XCTAssertEqual(halfQuarter * halfQuarter * p, point(-1, 0, 0))
        XCTAssertEqual(fullQuarter * p, point(-1, 0, 0))
    }
    
    func testShearingMovesOneComponentOfPointInProportionToOtherComponents() {
        let p = point(2, 3, 4)
        XCTAssertEqual(identity().sheared(xy: 1, xz: 0, yx: 0, yz: 0, zx: 0, zy: 0) * p, point(5, 3, 4))
        XCTAssertEqual(identity().sheared(xy: 0, xz: 1, yx: 0, yz: 0, zx: 0, zy: 0) * p, point(6, 3, 4))
        XCTAssertEqual(identity().sheared(xy: 0, xz: 0, yx: 1, yz: 0, zx: 0, zy: 0) * p, point(2, 5, 4))
        XCTAssertEqual(identity().sheared(xy: 0, xz: 0, yx: 0, yz: 1, zx: 0, zy: 0) * p, point(2, 7, 4))
        XCTAssertEqual(identity().sheared(xy: 0, xz: 0, yx: 0, yz: 0, zx: 1, zy: 0) * p, point(2, 3, 6))
        XCTAssertEqual(identity().sheared(xy: 0, xz: 0, yx: 0, yz: 0, zx: 0, zy: 1) * p, point(2, 3, 7))
    }
    
    func testIndividualTransformationsCanBeAppliedInSequence() {
        let p = point(1, 0, 1)
        let a = identity().rotatedAroundx(.pi / 2)
        let b = identity().scaled(5, 5, 5)
        let c = identity().translated(10, 5, 7)
        let p2 = a * p
        let p3 = b * p2
        let p4 = c * p3
        XCTAssertEqual(p2, point(1, -1, 0))
        XCTAssertEqual(p3, point(5, -5, 0))
        XCTAssertEqual(p4, point(15, 0 , 7))
    }
    
    func testChainedTransformationsMustBeAppliedInReverseOrder() {
        let p = point(1, 0, 1)
        let a = identity().rotatedAroundx(.pi / 2)
        let b = identity().scaled(5, 5, 5)
        let c = identity().translated(10, 5, 7)
        let t = c * b * a
        XCTAssertEqual(t * p, point(15, 0, 7))
    }
    
    func testTransformationsCanBeDeclaredInNaturalOrder() {
        let p = point(1, 0, 1)
        let t = identity()
            .rotatedAroundx(.pi / 2)
            .scaled(5, 5, 5)
            .translated(10, 5, 7)
        XCTAssertEqual(t * p, point(15, 0, 7))
    }
}
