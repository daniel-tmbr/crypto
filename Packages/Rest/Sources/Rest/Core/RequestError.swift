import Foundation

public struct RequestError: Error {
    public enum Category {
        case compose, network, response
    }
    
    public let error: Swift.Error
    public let category: Category
    
    public var localizedDescription: String {
        "RequestError.\(category):\n\(error.localizedDescription)\n\n\(error)"
    }
}

extension RequestError {
    init(urlError: URLError) {
        error = urlError
        category = .network
    }
}
