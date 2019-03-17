import RayTracerChallengeModel

func defaultWorld() -> World {
    let light = PointLight(point(-10, 10, -10), .white)
    let s1 = Sphere(material: Material(
            color: Color(0.8, 1.0, 0.6),
            diffuse: 0.7,
            specular: 0.2))
    let s2 = Sphere(transform: identity().scaled(0.5, 0.5, 0.5))
    return World(light: light, objects: [s1, s2])
}
