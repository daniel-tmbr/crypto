import Foundation

public struct Symbol: Decodable {
    public let symbol: SymbolPair
    public let status: SymbolStatus
    public let baseAsset: Asset
    public let basePrecision: Int
    public let quoteAsset: Asset
    public let quotePrecision: Int
    public let orderTypes: [OrderType]
    public let icebergAllowed: Bool
    public let ocoAllowed: Bool
    public let isSpotTradingAllowed: Bool
    public let isMarginTradingAllowed: Bool
    public let filters: [Filter]
}
