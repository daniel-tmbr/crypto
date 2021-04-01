import Foundation

public enum OrderSide: Decodable {
    case buy
    case sell
    case other(String)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case Raw.buy: self = .buy
        case Raw.sell: self = .sell
        default: self = .other(value) // TODO: Log undhandled case
        }
    }

    private struct Raw {
        static let buy = "BUY"
        static let sell = "SELL"
    }
}
