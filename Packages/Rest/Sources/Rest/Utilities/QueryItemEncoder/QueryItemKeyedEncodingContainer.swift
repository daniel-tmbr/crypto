import Foundation

public struct QueryItemKeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    public let codingPath: [CodingKey]
    private var container: QueryItemsContainer

    public init(codingPath: [CodingKey] = [], container: QueryItemsContainer) {
        self.codingPath = codingPath
        self.container = container
    }

    public mutating func encodeNil(forKey key: Key) throws {}

    public mutating func encode(_ value: Bool, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: String, forKey key: Key) throws {
        try container.append(value: value, for: key.stringValue)
    }

    public mutating func encode(_ value: Double, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: Float, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: Int, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: Int8, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: Int16, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: Int32, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: Int64, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: UInt, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: UInt8, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: UInt16, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: UInt32, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode(_ value: UInt64, forKey key: Key) throws {
        try encode("\(value)", forKey: key)
    }

    public mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        let encoder = QueryItemEncoder(codingPath: [key], container: container)
        try value.encode(to: encoder)
    }

    public mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let keyedContainer = QueryItemKeyedEncodingContainer<NestedKey>(
            codingPath: [key],
            container: container
        )
        return KeyedEncodingContainer(keyedContainer)
    }

    public mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        return QueryItemUnkeyedEncodingContainer(key: key, container: container)
    }

    public mutating func superEncoder() -> Encoder {
        let superKey = Key(stringValue: "String")!
        return superEncoder(forKey: superKey)
    }

    public mutating func superEncoder(forKey key: Key) -> Encoder {
        return QueryItemEncoder(codingPath: [key], container: container)
    }
}
