import Foundation

public enum RateLimitType: Codable {
    case requestWeight
    case orders
    case rawRequest
    case other(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case Raw.requestWeight: self = .requestWeight
        case Raw.orders: self = .orders
        case Raw.rawRequest: self = .rawRequest
        default: self = .other(value)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    private var value: String {
        switch self {
        case .requestWeight: return Raw.requestWeight
        case .orders: return Raw.orders
        case .rawRequest: return Raw.rawRequest
        case .other(let value): return value
        }
    }

    private struct Raw {
        static let requestWeight = "REQUEST_WEIGHT"
        static let orders = "ORDERS"
        static let rawRequest = "RAW_REQUESTS"
    }
}
