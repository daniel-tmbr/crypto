import Foundation

public struct SecureStringStore: ApiSecurityKey {
    private let store: SecurityKeyStore
    private let identifier: SecureStringIdentifier
    private let key: SecureStringKey
    private var label: String {
        "\(identifier.value).\(key.name)"
    }
    
    public init(store: SecurityKeyStore = SecKeyStore(),
                identifier: SecureStringIdentifier,
                key: SecureStringKey) {
        self.store = store
        self.identifier = identifier
        self.key = key
    }
    
    public func store(string: String?) throws {
        // Remove previous value
        try store.deleteKey(label: label)
        if let string = string {
            try store.storeKey(string, label: label)
        }
    }
    
    public func read() throws -> String? {
        try store.readKey(label: label)
    }
}

public struct SecureStringIdentifier {
    let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct SecureStringKey {
    let name: String
    
    public init(_ name: String) {
        self.name = name
    }
}
