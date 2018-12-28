import Foundation
import RayTracerChallengeModel

struct Projectile {
    let position: Tuple
    let velocity: Tuple
}

struct Environment {
    let gravity: Tuple
    let wind: Tuple
}

func tick(environment: Environment, projectile: Projectile) -> Projectile {
    let position = projectile.position + projectile.velocity
    let velocity = projectile.velocity + environment.gravity + environment.wind
    return Projectile(position: position, velocity: velocity)
}

func drawSquare(_ canvas: inout Canvas, center: (x: Int, y: Int)) {
    let red = Color(1, 0, 0)
    pairs(-1...1, -1...1).forEach { (dx, dy) in
        canvas[center.x + dx, center.y + dy] = red
    }
}

let start = Tuple(fromPoint: 0, 1, 0)
let velocity = Tuple(fromVector: 1, 1.8, 0).normalized() * 11.25
let p0 = Projectile(position: start, velocity: velocity)

let gravity = Tuple(fromVector: 0, -0.1, 0)
let wind = Tuple(fromVector: -0.01, 0, 0)
let e = Environment(gravity: gravity, wind: wind)

var c = Canvas(900, 550)

sequence(first: p0, next: { p in tick(environment: e, projectile: p) })
    .prefix(while: { p in p.position.y > 0 })
    .forEach({ p in
        let x = Int(p.position.x)
        let y = c.height - Int(p.position.y)
        drawSquare(&c, center: (x, y))
    })

if let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    let fileURL = dirURL.appendingPathComponent("projectiles.ppm")
    let ppm = CanvasToPPMConverter().ppm(from: c)
    try ppm.write(to: fileURL, atomically: false, encoding: .utf8)
    print("Written to \(fileURL)")
}
