import Foundation
import RayTracerChallengeModel

func drawSquare(_ canvas: inout Canvas, center: (x: Int, y: Int)) {
    let size = 2
    pairs(-size...size, -size...size).forEach { (dx, dy) in
        canvas[center.x + dx, center.y + dy] = .white
    }
}

var c = Canvas(700, 500)
let radius = Double(min(c.width, c.height)) * 3 / 8
let xCenter = Double(c.width) / 2
let yCenter = Double(c.height) / 2

(0..<12).forEach { hour in
    let angle = Double(hour) * (.pi / 6)
    let transform = identity()
        .rotatedAroundx(angle)
        .scaled(1, radius, radius)
        .translated(0, yCenter, xCenter)
    let p = transform * point(0, 1, 0)
    drawSquare(&c, center: (Int(p.z), c.height - Int(p.y)))
}

if let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    let fileURL = dirURL.appendingPathComponent("clock.ppm")
    let ppm = CanvasToPPMConverter().ppm(from: c)
    try ppm.write(to: fileURL, atomically: false, encoding: .utf8)
    print("\(fileURL)")
}
