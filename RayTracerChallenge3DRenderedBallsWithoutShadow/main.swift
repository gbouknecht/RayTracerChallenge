import Foundation
import RayTracerChallengeModel

let floor = Sphere(
        transform: identity()
                .scaled(10, 0.01, 10),
        material: Material(
                color: Color(1, 0.9, 0.9),
                specular: 0))
let leftWall = Sphere(
        transform: identity()
                .scaled(10, 0.01, 10)
                .rotatedAroundx(.pi / 2.0)
                .rotatedAroundy(-.pi / 4.0)
                .translated(0, 0, 5),
        material: floor.material)
let rightWall = Sphere(
        transform: identity()
                .scaled(10, 0.01, 10)
                .rotatedAroundx(.pi / 2.0)
                .rotatedAroundy(.pi / 4.0)
                .translated(0, 0, 5),
        material: floor.material)
let middle = Sphere(
        transform: identity()
                .translated(-0.5, 1, 0.5),
        material: Material(
                color: Color(0.1, 1, 0.5),
                diffuse: 0.7,
                specular: 0.3))
let right = Sphere(
        transform: identity()
                .scaled(0.5, 0.5, 0.5)
                .translated(1.5, 0.5, -0.5),
        material: Material(
                color: Color(0.5, 1, 0.1),
                diffuse: 0.7,
                specular: 0.3))
let left = Sphere(
        transform: identity()
                .scaled(0.33, 0.33, 0.33)
                .translated(-1.5, 0.33, -0.75),
        material: Material(
                color: Color(1, 0.8, 0.1),
                diffuse: 0.7,
                specular: 0.3))

let world = World(light: PointLight(point(-10, 10, -10), .white),
                  objects: [floor, leftWall, rightWall, middle, right, left])

var camera = Camera(hsize: 100, vsize: 50, fieldOfView: .pi / 3.0)
camera.transform = viewTransform(from: point(0, 1.5, -5), to: point(0, 1, 0), up: vector(0, 1, 0))

let canvas = camera.render(world)

if let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    let fileURL = dirURL.appendingPathComponent("3d-rendered-balls-without-shadow.ppm")
    let ppm = CanvasToPPMConverter().ppm(from: canvas)
    try ppm.write(to: fileURL, atomically: false, encoding: .utf8)
    print("\(fileURL)")
}
