import Foundation

public enum OrderType: Decodable {
    case limit
    case market
    case stopLoss
    case stopLossLimit
    case takeProfit
    case takeProfitLimit
    case limitMaker
    case other(String)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case Raw.limit: self = .limit
        case Raw.market: self = .market
        case Raw.stopLoss: self = .stopLoss
        case Raw.stopLossLimit: self = .stopLossLimit
        case Raw.takeProfit: self = .takeProfit
        case Raw.takeProfitLimit: self = .takeProfitLimit
        case Raw.limitMaker: self = .limitMaker
        default: self = .other(value)
        }
    }

    private struct Raw {
        static let limit = "LIMIT"
        static let market = "MARKET"
        static let stopLoss = "STOP_LOSS"
        static let stopLossLimit = "STOP_LOSS_LIMIT"
        static let takeProfit = "TAKE_PROFIT"
        static let takeProfitLimit = "TAKE_PROFIT_LIMIT"
        static let limitMaker = "LIMIT_MAKER"
    }
}



