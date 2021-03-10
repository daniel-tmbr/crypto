import Foundation

public struct QueryItemUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    private let key: CodingKey?
    private var container: QueryItemsContainer
    public let count: Int = 0
    public var codingPath: [CodingKey] { [key].compactMap { $0 } }

    public init(key: CodingKey? = nil, container: QueryItemsContainer) {
        self.key = key
        self.container = container
    }

    public mutating func encodeNil() throws {}

    public mutating func encode(_ value: Bool) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: String) throws {
        guard let key = key else { return }
        try container.append(value: value, for: key.stringValue)
    }

    public mutating func encode(_ value: Double) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: Float) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: Int) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: Int8) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: Int16) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: Int32) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: Int64) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: UInt) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: UInt8) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: UInt16) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: UInt32) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: UInt64) throws {
        try encode("\(value)")
    }

    public mutating func encode<T>(_ value: T) throws where T : Encodable {
        let encoder = QueryItemEncoder(codingPath: codingPath, container: container)
        try value.encode(to: encoder)
    }

    public mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let keyedContainer = QueryItemKeyedEncodingContainer<NestedKey>(
            codingPath: codingPath,
            container: container
        )
        return KeyedEncodingContainer(keyedContainer)
    }

    public mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        return QueryItemUnkeyedEncodingContainer(key: key, container: container)
    }

    public mutating func superEncoder() -> Encoder {
        return QueryItemEncoder(codingPath: codingPath, container: container)
    }
}
