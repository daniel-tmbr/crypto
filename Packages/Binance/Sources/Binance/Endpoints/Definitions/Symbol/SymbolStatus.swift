import Foundation

public enum SymbolStatus: Decodable {
    case preTrading
    case trading
    case postTrading
    case endOfDay
    case halt
    case auctionMatch
    case `break`
    case other(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case Raw.preTrading: self = .preTrading
        case Raw.trading: self = .trading
        case Raw.postTrading: self = .postTrading
        case Raw.endOfDay: self = .endOfDay
        case Raw.halt: self = .halt
        case Raw.auctionMatch: self = .auctionMatch
        case Raw.`break`: self = .`break`
        default: self = .other(value)
        }
    }

    private struct Raw {
        static let preTrading = "PRE_TRADING"
        static let trading = "TRADING"
        static let postTrading = "POST_TRADING"
        static let endOfDay = "END_OF_DAY"
        static let halt = "HALT"
        static let auctionMatch = "AUCTION_MATCH"
        static let `break` = "BREAK"
    }
}
