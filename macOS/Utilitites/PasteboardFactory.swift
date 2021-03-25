import Foundation
import AppKit

struct PasteboardFactory {
    static let general: Pasteboard = NSPasteboard.general
}

extension NSPasteboard: Pasteboard {
    func getString() -> String? { string(forType: .string) }
}
