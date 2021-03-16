import SwiftUI

extension Color {
    #if os(macOS)
    static let secondaryLabel = Color(.secondaryLabelColor)
    #else
    static let secondaryLabel = Color(.secondaryLabel)
    #endif
}
