import Foundation

public struct StringSecKeyStore: ConsumerKeyStore {
    public let type: ConsumerKeyType
    private let store: SecurityKeyStore
    private let identifier: String
    private var label: String { "\(identifier).\(type.identifier)" }
    
    public init(store: SecurityKeyStore, identifier: String, type: ConsumerKeyType) {
        self.store = store
        self.identifier = identifier
        self.type = type
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
