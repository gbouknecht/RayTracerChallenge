public struct Canvas {
    public let width: Int
    public let height: Int
    
    private var pixels: [[Color]]
    
    public init(_ width: Int, _ height: Int) {
        self.width = width
        self.height = height
        self.pixels = Array(repeating: Array(repeating: Color(0, 0, 0), count: height), count: width)
    }
    
    public subscript(x: Int, y: Int) -> Color {
        get {
            return pixels[x][y]
        }
        set {
            pixels[x][y] = newValue
        }
    }
}
