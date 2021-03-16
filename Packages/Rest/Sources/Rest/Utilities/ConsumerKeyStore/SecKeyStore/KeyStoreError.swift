/*
 Source: https://developer.apple.com/documentation/cryptokit/storing_cryptokit_keys_in_the_keychain
 */

import Foundation

/// An error we can throw when something goes wrong.
public struct KeyStoreError: Error, CustomStringConvertible {
    public enum Category {
        case store
        case decode
        case read
        case readDataType
        case delete
    }
    
    public let category: Category
    public let message: String
    public var description: String { message }
    
    init(category: Category, message: String) {
        self.category = category
        self.message = message
    }
}

extension OSStatus {
    /// A human readable message for the status.
    public var message: String {
        (SecCopyErrorMessageString(self, nil) as String?) ?? String(self)
    }
}
