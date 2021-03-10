import Foundation

public struct QueryItemEncoder: Encoder {
    public let codingPath: [CodingKey]
    public let userInfo: [CodingUserInfoKey : Any]
    private var container: QueryItemsContainer
    
    public init(codingPath: [CodingKey] = [],
                userInfo: [CodingUserInfoKey : Any] = [:],
                container: QueryItemsContainer = URLQueryItemContainer()) {
        self.codingPath = codingPath
        self.userInfo = userInfo
        self.container = container
    }
    
    public func encode<Value>(_ value: Value) throws -> [URLQueryItem] where Value: Encodable {
        try value.encode(to: self)
        return container.queryItems
    }
    
    public mutating func append(value: String, for key: String) throws {
        try container.append(value: value, for: key)
    }
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        let keyedContainer = QueryItemKeyedEncodingContainer<Key>(
            codingPath: codingPath,
            container: container
        )
        return KeyedEncodingContainer(keyedContainer)
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        QueryItemUnkeyedEncodingContainer(container: container)
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        QueryItemSingleValueEncodingContainer(
            codingPath: codingPath,
            container: container
        )
    }
}
