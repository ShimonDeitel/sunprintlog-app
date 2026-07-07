import SwiftUI

/// Unique visual identity for Sunprint Log.
enum Theme {
    static let background = Color(hex: "#2B1218")
    static let accent = Color(hex: "#FF8552")
    static let secondary = Color(hex: "#FFC15E")
    static let textPrimary = Color(hex: "#FCEEE3")

    static let titleFont: Font = .system(.largeTitle, design: .rounded).weight(.bold)
    static let bodyFont: Font = .system(.body, design: .rounded)

    static let cardCorner: CGFloat = 18
}

extension Color {
    init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var rgb: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
