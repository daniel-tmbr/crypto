/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Methods for storing SecKey convertible items in the keychain.
*/

import Foundation
import CryptoKit
import Security

public protocol SecurityKeyStore {
    /// Reads a key from the keychain as a SecKey instance.
    func readKey<T: SecKeyConvertible>(label: String) throws -> T?
    /// Stores a key in the keychain as a SecKey instance.
    func storeKey<T: SecKeyConvertible>(_ key: T, label: String) throws
    /// Removes any existing key with the given label.
    func deleteKey(label: String) throws
}

public struct SecKeyStore: SecurityKeyStore {
    private let identifier: String
    
    public init(bundle: Bundle = .main) {
        identifier = bundle.bundleIdentifier ?? bundle.bundlePath
    }
    
    /// Stores a CryptoKit key in the keychain as a SecKey instance.
    public func storeKey<T: SecKeyConvertible>(_ key: T, label: String) throws {
        // Treat the key data as a generic password.
        let query = [kSecClass: kSecClassGenericPassword,
                     kSecAttrAccount: "\(identifier).\(label)",
                     kSecAttrSynchronizable: true,
                     kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
                     kSecUseDataProtectionKeychain: true,
                     kSecValueData: key.rawRepresentation] as [String: Any]
        // Add the key data.
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeyStoreError(category: .store, message: "Unable to store item: \(status.message)")
        }
   }
    
    /// Reads a CryptoKit key from the keychain as a SecKey instance.
    public func readKey<T: SecKeyConvertible>(label: String) throws -> T? {
        // Seek a generic password with the given account.
        let query = [kSecClass: kSecClassGenericPassword,
                     kSecAttrAccount: "\(identifier).\(label)",
                     kSecAttrSynchronizable: true,
                     kSecUseDataProtectionKeychain: true,
                     kSecReturnData: true] as [String: Any]
        // Find and cast the result as data.
        var item: CFTypeRef?
        switch SecItemCopyMatching(query as CFDictionary, &item) {
        case errSecSuccess:
            guard let data = item as? Data else {
                throw KeyStoreError(category: .readDataType, message: "Unexpected type: \(String(describing: item))")
            }
            return try T(rawRepresentation: data)
        case errSecItemNotFound:
            return nil
        case let status:
            throw KeyStoreError(category: .read, message: "Unable to read item: \(status.message)")
        }
    }
    
    /// Removes any existing key with the given label.
    public func deleteKey(label: String) throws {
        let query = [kSecClass: kSecClassGenericPassword,
                     kSecUseDataProtectionKeychain: true,
                     kSecAttrSynchronizable: true,
                     kSecAttrAccount: "\(identifier).\(label)"] as [String: Any]
        switch SecItemDelete(query as CFDictionary) {
        case errSecItemNotFound, errSecSuccess:
            break
        case let status:
            throw KeyStoreError(category: .delete, message: "Unable to delete item: \(status.message)")
        }
    }
}
