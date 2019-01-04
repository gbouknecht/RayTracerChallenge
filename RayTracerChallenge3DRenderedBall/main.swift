import Foundation
import RayTracerChallengeModel

let rayOrigin = point(0, 0, -5)
let wallz = 10.0
let wallSize = 7.0
let canvasPixels = 100
let pixelSize = wallSize / Double(canvasPixels)
let half = wallSize / 2

var canvas = Canvas(canvasPixels, canvasPixels)

let shape = Sphere(material: Material(color: Color(1, 0.2, 1)))
let light = PointLight(point(-10, 10, -10), .white)

(0..<canvasPixels).forEach { y in
    let worldy = half - pixelSize * Double(y)
    (0..<canvasPixels).forEach { x in
        let worldx = -half + pixelSize * Double(x)
        let position = point(worldx, worldy, wallz)
        let ray = Ray(rayOrigin, (position - rayOrigin).normalized())
        if let hit = shape.intersect(ray).hit() {
            let point = ray.position(hit.t)
            let eye = -ray.direction
            let normal = shape.normalAt(point)
            let color = lighting(material: shape.material, light: light, point: point, eyev: eye, normalv: normal)
            canvas[x, y] = color
        }
    }
}

if let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    let fileURL = dirURL.appendingPathComponent("3d-rendered-ball.ppm")
    let ppm = CanvasToPPMConverter().ppm(from: canvas)
    try ppm.write(to: fileURL, atomically: false, encoding: .utf8)
    print("\(fileURL)")
}
