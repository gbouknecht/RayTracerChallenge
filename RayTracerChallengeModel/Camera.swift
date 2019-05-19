import Foundation

public struct Camera {
    public let hsize: Int
    public let vsize: Int
    public let fieldOfView: Double
    private let halfWidth: Double
    private let halfHeight: Double
    public let pixelSize: Double
    public var transform = identity()

    public init(hsize: Int, vsize: Int, fieldOfView: Double) {
        self.hsize = hsize
        self.vsize = vsize
        self.fieldOfView = fieldOfView
        (self.halfWidth, self.halfHeight, self.pixelSize) = halfWidthAndHalfHeightAndPixelSize(hsize: hsize,
                                                                                               vsize: vsize,
                                                                                               fieldOfView: fieldOfView)
    }

    public func rayForPixel(_ x: Int, _ y: Int) -> Ray {
        let xoffset = (Double(x) + 0.5) * pixelSize
        let yoffset = (Double(y) + 0.5) * pixelSize
        let worldx = halfWidth - xoffset
        let worldy = halfHeight - yoffset
        let pixel = transform.inverted() * point(worldx, worldy, -1)
        let origin = transform.inverted() * point(0, 0, 0)
        let direction = (pixel - origin).normalized()
        return Ray(origin, direction)
    }

    public func render(_ world: World) -> Canvas {
        var image = Canvas(hsize, vsize)
        (0..<vsize).forEach { y in
            (0..<hsize).forEach { x in
                let ray = rayForPixel(x, y)
                let color = world.colorAt(ray)
                image[x, y] = color
            }
        }
        return image
    }
}

fileprivate func halfWidthAndHalfHeightAndPixelSize(hsize: Int, vsize: Int, fieldOfView: Double) -> (Double, Double, Double) {
    let (halfWidth, halfHeight) = halfWidthAndHalfHeight(hsize: hsize, vsize: vsize, fieldOfView: fieldOfView)
    return (halfWidth, halfHeight, 2 * halfWidth / Double(hsize))
}

fileprivate func halfWidthAndHalfHeight(hsize: Int, vsize: Int, fieldOfView: Double) -> (Double, Double) {
    let halfView = tan(fieldOfView / 2)
    let aspect = Double(hsize) / Double(vsize)
    if aspect >= 1 {
        return (halfView, halfView / aspect)
    } else {
        return (halfView * aspect, halfView)
    }
}
