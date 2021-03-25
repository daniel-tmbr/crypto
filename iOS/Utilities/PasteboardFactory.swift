import Foundation
import UIKit

struct PasteboardFactory {
    static let general: Pasteboard = UIPasteboard.general
}

extension UIPasteboard: Pasteboard {
    func getString() -> String? { string }
}
