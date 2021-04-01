import Foundation

public enum AccountSnapshotType: Codable {
    case spot, margin, futures, other(String)

    private struct Values {
        static let spot = "SPOT"
        static let margin = "MARGIN"
        static let futures = "FUTURES"
    }

    private enum Key: CodingKey { case type }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let value = try container.decode(String.self, forKey: .type)
        switch value {
        case Values.spot: self = .spot
        case Values.margin: self = .margin
        case Values.futures: self = .futures
        default: self = .other(value)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(value, forKey: .type)
    }

    private var value: String {
        switch self {
        case .spot: return Values.spot
        case .margin: return Values.margin
        case .futures: return Values.futures
        case .other(let value): return value
        }
    }
}
