import Foundation

public class CanvasToPPMConverter {
    private static let maxColorValue = 255
    private static let maxLineLength = 70

    public func ppm(from canvas: Canvas) -> String {
        return header(canvas) + "\n" + pixels(canvas) + "\n"
    }
    
    private func header(_ canvas: Canvas) -> String {
        return """
               P3
               \(canvas.width) \(canvas.height)
               \(CanvasToPPMConverter.maxColorValue)
               """
    }
    
    private func pixels(_ canvas: Canvas) -> String {
        return (0..<canvas.height).map { y in pixels(canvas, y) }.joined(separator: "\n")
    }
    
    private func pixels(_ canvas: Canvas, _ y: Int) -> String {
        let pixels = (0..<canvas.width)
            .flatMap { x in scaledColorValues(color: canvas[x, y]) }
            .map { String($0) }
            .joined(separator: " ")
        return splitOnMaxLineLength(pixels)
    }
    
    private func splitOnMaxLineLength(_ pixels: String) -> String {
        if pixels.count <= CanvasToPPMConverter.maxLineLength {
            return pixels
        } else {
            let startIndex = pixels.startIndex
            let index0 = pixels.index(startIndex, offsetBy: CanvasToPPMConverter.maxLineLength)
            let index = sequence(first: index0, next: { pixels.index(before: $0) }).first(where: { pixels[$0] == " " })!
            let nextIndex = pixels.index(after: index)
            let endIndex = pixels.endIndex
            return pixels[startIndex..<index] + "\n" + splitOnMaxLineLength(String(pixels[nextIndex..<endIndex]))
        }
    }
    
    private func scaledColorValues(color: Color) -> [Int] {
        let scale = { max(min(Int(($0 * Double(CanvasToPPMConverter.maxColorValue)).rounded()), CanvasToPPMConverter.maxColorValue), 0) }
        return [scale(color.red), scale(color.green), scale(color.blue)]
    }
}
