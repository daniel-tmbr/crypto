import Combine
import Foundation
import Rest

final class SecurityKey: ObservableObject {
    private let pasteboard: Pasteboard
    private let key: ApiSecurityKey
    
    let name: String
    @Published
    var value: String = ""
    @Published
    var error: String = ""
    
    init(name: String,
         key: ApiSecurityKey,
         pasteboard: Pasteboard = PasteboardFactory.general) {
        self.name = name
        self.key = key
        self.pasteboard = pasteboard
        read()
    }
        
    func commit() {
        store(key: value)
    }
    
    func paste() {
        clearError()
        if let string = pasteboard.getString() {
            store(key: string)
        } else {
            error = L10n.SecurityKey.emptyPasteboard
        }
    }
    
    private func read() {
        clearError()
        do {
            value = mask(key: try key.read() ?? "")
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func store(key: String) {
        clearError()
        do {
            try self.key.store(string: key)
            value = mask(key: key)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func clearError() {
        error = ""
    }
    
    private func mask(key: String) -> String {
        String(key.map { _ in "•" })
    }
}
