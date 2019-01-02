import Foundation
import RayTracerChallengeModel

let rayOrigin = point(0, 0, -5)
let wallz = 10.0
let wallSize = 14.0
let canvasPixels = 100
let pixelSize = wallSize / Double(canvasPixels)
let half = wallSize / 2

var canvas = Canvas(canvasPixels, canvasPixels)
let color = Color(1, 0, 0)

let shape1 = Sphere(transform: identity()
    .translated(-1, 1, 0))
let shape2 = Sphere(transform: identity()
    .scaled(0.5, 1, 1)
    .translated(1, 1, 0))
let shape3 = Sphere(transform: identity()
    .scaled(0.5, 1, 1)
    .rotatedAroundz(.pi / 4)
    .translated(-1, -1, 0))
let shape4 = Sphere(transform: identity()
    .scaled(0.5, 1, 1)
    .sheared(xy: 1, xz: 0, yx: 0, yz: 0, zx: 0, zy: 0)
    .translated(1, -1, 0))

(0..<canvasPixels).forEach { y in
    let worldy = half - pixelSize * Double(y)
    (0..<canvasPixels).forEach { x in
        let worldx = -half + pixelSize * Double(x)
        let position = point(worldx, worldy, wallz)
        let r = Ray(rayOrigin, (position - rayOrigin).normalized())
        if [shape1, shape2, shape3, shape4].contains(where: { $0.intersect(r).hit() != nil }) {
            canvas[x, y] = color
        }
    }
}

if let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    let fileURL = dirURL.appendingPathComponent("ball-shadow.ppm")
    let ppm = CanvasToPPMConverter().ppm(from: canvas)
    try ppm.write(to: fileURL, atomically: false, encoding: .utf8)
    print("\(fileURL)")
}
