func equal(_ a: Double, _ b: Double) -> Bool {
    return abs(a - b) < 0.00001
}

func pairs<C: Collection>(_ c1: C, _ c2: C) -> [(Int, Int)] where C.Iterator.Element == Int {
    return c1.flatMap { e1 in c2.map { e2 in (e1, e2) } }
}
