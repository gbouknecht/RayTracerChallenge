public struct Canvas {
    public let width: Int
    public let height: Int
    
    private var pixels: [[Color]]
    
    public init(_ width: Int, _ height: Int) {
        self.width = width
        self.height = height
        self.pixels = Array(repeating: Array(repeating: .black, count: height), count: width)
    }
    
    public subscript(x: Int, y: Int) -> Color {
        get {
            return pixels[x][y]
        }
        set {
            if x >= 0 && x < width && y >= 0 && y < height {
                pixels[x][y] = newValue
            }
        }
    }
}
