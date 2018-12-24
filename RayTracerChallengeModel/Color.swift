public struct Color {
    public let red: Double
    public let green: Double
    public let blue: Double
    
    public init (_ red: Double, _ green: Double, _ blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

// MARK: - Equatable

extension Color: Equatable {
    public static func ==(lhs: Color, rhs: Color) -> Bool {
        return equal(lhs.red, rhs.red)
            && equal(lhs.green, rhs.green)
            && equal(lhs.blue, rhs.blue)
    }
}

// MARK: - Operations

extension Color {
    public static func +(_ a: Color, _ b: Color) -> Color {
        return Color(a.red + b.red, a.green + b.green, a.blue + b.blue)
    }

    public static func -(_ a: Color, _ b: Color) -> Color {
        return Color(a.red - b.red, a.green - b.green, a.blue - b.blue)
    }
    
    public static func *(_ a: Color, _ b: Double) -> Color {
        return Color(a.red * b, a.green * b, a.blue * b)
    }
    
    public static func *(_ a: Color, _ b: Color) -> Color {
        return Color(a.red * b.red, a.green * b.green, a.blue * b.blue)
    }
}
