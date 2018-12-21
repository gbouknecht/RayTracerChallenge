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

let p0 = Projectile(position: Tuple(fromPoint: 0, 1, 0), velocity: Tuple(fromVector: 1, 1, 0))
let e = Environment(gravity: Tuple(fromVector: 0, -0.1, 0), wind: Tuple(fromVector: -0.01, 0, 0))
sequence(first: p0, next: { p in tick(environment: e, projectile: p) })
    .prefix(while: { p in p.position.y > 0 })
    .enumerated()
    .forEach { (i, p) in print(String(format: "%2d: (%6.2f, %6.2f)", i, p.position.x, p.position.y)) }
