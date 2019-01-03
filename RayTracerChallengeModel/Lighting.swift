import Foundation

func lighting(material: Material, light: PointLight, point: Tuple, eyev: Tuple, normalv: Tuple) -> Color {
    let effectiveColor = material.color * light.intensity
    let lightv = (light.position - point).normalized()
    let ambient = effectiveColor * material.ambient
    let lightDotNormal = lightv.dot(normalv)
    let diffuse: Color
    let specular: Color
    if lightDotNormal < 0 {
        diffuse = Color(0, 0, 0)
        specular = Color(0, 0, 0)
    } else {
        diffuse = effectiveColor * material.diffuse * lightDotNormal
        let reflectv = -lightv.reflected(normalv)
        let reflectDotEye = reflectv.dot(eyev)
        if reflectDotEye <= 0 {
            specular = Color(0, 0, 0)
        } else {
            let factor = pow(reflectDotEye, material.shininess)
            specular = light.intensity * material.specular * factor
        }
    }
    return ambient + diffuse + specular
}
