/*
 Source: https://developer.apple.com/documentation/cryptokit/storing_cryptokit_keys_in_the_keychain
 */

import Foundation
import CryptoKit

/// The interface needed for SecKey conversion.
public protocol SecKeyConvertible: CustomStringConvertible {
    /// Creates a key from a raw representation.
    init(rawRepresentation data: Data) throws
    
    /// A raw representation of the key.
    var rawRepresentation: Data { get }
}

extension SecKeyConvertible {
    /// A string version of the key for visual inspection.
    /// IMPORTANT: Never log the actual key data.
    public var description: String {
        rawRepresentation.withUnsafeBytes { bytes in
            "Key representation contains \(bytes.count) bytes."
        }
    }
}

extension String: SecKeyConvertible {
    public init(rawRepresentation data: Data) throws {
        guard let string = String(data: data, encoding: .utf8)
            else { throw KeyStoreError(category: .decode, message: "Data is not utf8 encoded") }
        self = string
    }
    
    public var rawRepresentation: Data {
        data(using: .utf8) ?? Data()
    }
}
