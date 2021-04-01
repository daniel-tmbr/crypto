import Foundation

public struct CandlestickParams: Encodable {
    public let symbol: SymbolPair
    public let interval: CandlestickInterval
    /// Default 500, max 1000
    public let limit: Int
    public let startTime: TimeInterval?
    public let endTime: TimeInterval?

    /// If `startTime` and `endTime` are not sent, the most recent klines are returned.
    ///
    /// - parameter limit: Default value is 500, max is 1000
    public init(
        symbol: SymbolPair,
        interval: CandlestickInterval,
        startTime: TimeInterval? = nil,
        endTime: TimeInterval? = nil,
        limit: Int = 500
    ) {
        self.symbol = symbol
        self.interval = interval
        self.startTime = startTime
        self.endTime = endTime
        self.limit = limit
    }
}
