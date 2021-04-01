import Foundation

/// m -> minutes; h -> hours; d -> days; w -> weeks; M -> months
public enum CandlestickInterval: Codable {
    case min1, min3, min5, min15, min30
    case hour1, hour2, hour4, hour6, hour8, hour12
    case day1, day3
    case week1
    case month1
    case other(String)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case Raw.min1: self = .min1
        case Raw.min3: self = .min3
        case Raw.min5: self = .min5
        case Raw.min15: self = .min15
        case Raw.min30: self = .min30
        case Raw.hour1: self = .hour1
        case Raw.hour2: self = .hour2
        case Raw.hour4: self = .hour4
        case Raw.hour6: self = .hour6
        case Raw.hour8: self = .hour8
        case Raw.hour12: self = .hour12
        case Raw.day1: self = .day1
        case Raw.day3: self = .day3
        case Raw.week1: self = .week1
        case Raw.month1: self = .month1
        default: self = .other(value)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    private var value: String {
        switch self {
        case .min1: return Raw.min1
        case .min3: return Raw.min3
        case .min5: return Raw.min5
        case .min15: return Raw.min15
        case .min30: return Raw.min30
        case .hour1: return Raw.hour1
        case .hour2: return Raw.hour2
        case .hour4: return Raw.hour4
        case .hour6: return Raw.hour6
        case .hour8: return Raw.hour8
        case .hour12: return Raw.hour12
        case .day1: return Raw.day1
        case .day3: return Raw.day3
        case .week1: return Raw.week1
        case .month1: return Raw.month1
        case .other(let value): return value
        }
    }

    private struct Raw {
        static let min1 = "1m"
        static let min3 = "3m"
        static let min5 = "5m"
        static let min15 = "15m"
        static let min30 = "30m"
        static let hour1 = "1h"
        static let hour2 = "2h"
        static let hour4 = "4h"
        static let hour6 = "6h"
        static let hour8 = "8h"
        static let hour12 = "12h"
        static let day1 = "1d"
        static let day3 = "3d"
        static let week1 = "1w"
        static let month1 = "1M"
    }
}
