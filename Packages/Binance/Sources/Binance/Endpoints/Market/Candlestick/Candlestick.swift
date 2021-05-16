import Foundation

enum CanldestickError: Error {
    case missingValues(count: Int)
    case typeMismatch(key: String?)
}

/// ```
/// // Sample data:
/// // https://binance-docs.github.io/apidocs/spot/en/#kline-candlestick-data
/// [
///   1499040000000,      // Open time
///   "0.01634790",       // Open
///   "0.80000000",       // High
///   "0.01575800",       // Low
///   "0.01577100",       // Close
///   "148976.11427815",  // Volume
///   1499644799999,      // Close time
///   "2434.19055334",    // Quote asset volume
///   308,                // Number of trades
///   "1756.87402397",    // Taker buy base asset volume
///   "28.46694368",      // Taker buy quote asset volume
/// ]
/// ```

public struct Candlestick: Decodable {
    public let openTime: TimeInterval
    public let open: BinanceDouble
    public let high: BinanceDouble
    public let low: BinanceDouble
    public let close: BinanceDouble
    public let volume: BinanceDouble
    public let closeTime: TimeInterval
    public let quoteAssetVolume: BinanceDouble
    public let numberOfTrades: Int
    public let takerBuyBaseAssetVolume: BinanceDouble
    public let takerBuyQuoteAssetVolume: BinanceDouble

//    public init(
//        openTime: TimeInterval,
//        open: Double,
//        high: Double,
//        low: Double,
//        close: Double,
//        volume: Double,
//        closeTime: TimeInterval,
//        quoteAssetVolume: Double,
//        numberOfTrades: Int,
//        takerBuyBaseAssetVolume: Double,
//        takerBuyQuoteAssetVolume: Double
//    ) {
//        self.openTime = openTime
//        self.open = BinanceDouble(value: open)
//        self.high = BinanceDouble(value: high)
//        self.low = BinanceDouble(value: low)
//        self.close = BinanceDouble(value: close)
//        self.volume = BinanceDouble(value: volume)
//        self.closeTime = closeTime
//        self.quoteAsseVolume = BinanceDouble(value: quoteAsseVolume)
//        self.numberOfTrades = numberOfTrades
//        self.takerBuyBaseAssetVolume = BinanceDouble(value: takerBuyBaseAssetVolume)
//        self.takerBuyQuoteAssetVolume = BinanceDouble(value: takerBuyQuoteAssetVolume)
//    }

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        guard (container.count ?? 0) >= 11
            else { throw CanldestickError.missingValues(count: container.count ?? 0) }
        openTime = try container.decode(TimeInterval.self)
        open = try container.decode(BinanceDouble.self)
        high = try container.decode(BinanceDouble.self)
        low = try container.decode(BinanceDouble.self)
        close = try container.decode(BinanceDouble.self)
        volume = try container.decode(BinanceDouble.self)
        closeTime = try container.decode(TimeInterval.self)
        quoteAssetVolume = try container.decode(BinanceDouble.self)
        numberOfTrades = try container.decode(Int.self)
        takerBuyBaseAssetVolume = try container.decode(BinanceDouble.self)
        takerBuyQuoteAssetVolume = try container.decode(BinanceDouble.self)
    }
}
