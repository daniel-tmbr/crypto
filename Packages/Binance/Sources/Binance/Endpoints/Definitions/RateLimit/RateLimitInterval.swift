import Foundation

public enum RateLimitInterval: Codable {
    case second
    case minute
    case day
    case other(String)
    
    var interval: TimeInterval {
        switch self {
        case .second: return 1
        case .minute: return 1 * 60
        case .day: return 1 * 60 * 24
        case .other: return 1 * 60 * 24
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case Raw.second: self = .second
        case Raw.minute: self = .minute
        case Raw.day: self = .day
        default: self = .other(value)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    private var value: String {
        switch self {
        case .second: return Raw.second
        case .minute: return Raw.minute
        case .day: return Raw.day
        case .other(let value): return value
        }
    }

    private struct Raw {
        static let second = "SECOND"
        static let minute = "MINUTE"
        static let day = "DAY"
    }
}
