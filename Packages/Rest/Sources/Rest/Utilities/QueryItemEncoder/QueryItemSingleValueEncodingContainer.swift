import Foundation

public struct QueryItemSingleValueEncodingContainer: SingleValueEncodingContainer {
    enum EncodeError: Error {
        case emptyCodingPath
    }

    public let codingPath: [CodingKey]
    private var container: QueryItemsContainer

    public init(codingPath: [CodingKey], container: QueryItemsContainer) {
        self.codingPath = codingPath
        self.container = container
    }

    public mutating func encodeNil() throws {}

    public mutating func encode(_ value: Bool) throws {
        try encode("\(value)")
    }

    public mutating func encode(_ value: String) throws {
        guard let key = codingPath.last
            else { throw EncodeError.emptyCodingPath }
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

    public mutating func encode<T>(_ value: T) throws where T : Encodable {}

    public mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        KeyedEncodingContainer(QueryItemKeyedEncodingContainer<NestedKey>(container: URLQueryItemContainer()))
    }

    public mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        QueryItemUnkeyedEncodingContainer(container: URLQueryItemContainer())
    }

    public mutating func superEncoder() -> Encoder {
        QueryItemEncoder()
    }
}
