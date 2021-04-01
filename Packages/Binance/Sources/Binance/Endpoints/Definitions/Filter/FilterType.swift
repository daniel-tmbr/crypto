import Foundation

public enum FilterType: Decodable {
    case priceFilter
    case percentPrice
    case lotSize
    case minNotional
    case icebergParts
    case marketLitSize
    case maxNumOrders
    case maxNumAlgoOrders
    case maxNumIcebergOrders
    case exchangeMaxNumOrders
    case exchangeMaxAlgoOrders
    case other(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case Raw.priceFilter: self = .priceFilter
        case Raw.percentPrice: self = .percentPrice
        case Raw.lotSize: self = .lotSize
        case Raw.minNotional: self = .minNotional
        case Raw.icebergParts: self = .icebergParts
        case Raw.marketLitSize: self = .marketLitSize
        case Raw.maxNumOrders: self = .maxNumOrders
        case Raw.maxNumAlgoOrders: self = .maxNumAlgoOrders
        case Raw.maxNumIcebergOrders: self = .maxNumIcebergOrders
        case Raw.exchangeMaxNumOrders: self = .exchangeMaxNumOrders
        case Raw.exchangeMaxAlgoOrders: self = .exchangeMaxAlgoOrders
        default: self = .other(value) // TODO: Log unhandled case
        }
    }

    private struct Raw {
        static let priceFilter = "PRICE_FILTER"
        static let percentPrice = "PERCENT_PRICE"
        static let lotSize = "LOT_SIZE"
        static let minNotional = "MIN_NOTIONAL"
        static let icebergParts = "ICEBERG_PARTS"
        static let marketLitSize = "MARKET_LOT_SIZE"
        static let maxNumOrders = "MAX_NUM_ORDERS"
        static let maxNumAlgoOrders = "MAX_NUM_ALGO_ORDERS"
        static let maxNumIcebergOrders = "MAX_NUM_ICEBERG_ORDERS"
        static let exchangeMaxNumOrders = "EXCHANGE_MAX_NUM_ORDERS"
        static let exchangeMaxAlgoOrders = "EXCHANGE_MAX_ALGO_ORDERS"
    }
}



