import Foundation

public struct ConsumerKeyType {
    public let identifier: String
    public let name: String
}

extension ConsumerKeyType {
    public static let apiKey = ConsumerKeyType(identifier: "apiKey", name: "API Key")
    public static let secretKey = ConsumerKeyType(identifier: "secret", name: "API Secret")
}
