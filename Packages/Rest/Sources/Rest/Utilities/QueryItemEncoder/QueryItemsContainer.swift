import Foundation

public enum QueryItemContainerError: Error {
    case keyEncoding(String)
    case valueEncoding(String)
}

public protocol QueryItemsContainer {
    var queryItems: [URLQueryItem] { get }
    mutating func append(value: String, for key: String) throws
}

public final class URLQueryItemContainer: QueryItemsContainer {
    public enum UniqueingBehaviour {
        case none, retain, override
    }
    
    private let uniqueingBehaviour: UniqueingBehaviour
    private(set) public var queryItems: [URLQueryItem]
    
    public init(uniqueingBehaviour: UniqueingBehaviour = .retain,
                queryItems: [URLQueryItem] = []) {
        self.queryItems = queryItems
        self.uniqueingBehaviour = uniqueingBehaviour
    }
    
    public func append(value: String, for key: String) throws {
        guard let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else { throw QueryItemContainerError.keyEncoding(key) }
        guard let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else { throw QueryItemContainerError.valueEncoding(key) }
        switch uniqueingBehaviour {
        case .none:
            queryItems.append(URLQueryItem(name: encodedKey, value: encodedValue))
        case .override:
            queryItems.removeAll { $0.name == key }
            queryItems.append(URLQueryItem(name: encodedKey, value: encodedValue))
        case .retain:
            guard !queryItems.contains(where: { $0.name == key }) else { return }
            queryItems.append(URLQueryItem(name: encodedKey, value: encodedValue))
        }
    }
}
