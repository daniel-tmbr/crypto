import Foundation

public struct ExchangeInfo: Decodable, CustomStringConvertible {
    public let timezone: String
    public let serverTime: TimeInterval
    public let rateLimits: [RateLimit]
    public let exchangeFilters: [Filter]
    public let symbols: [Symbol]
    
    public var description: String {
        """
        \(String(describing: Self.self))
        \tServer time: \(Date(timeIntervalSince1970: serverTime.fromMilliseconds())) (\(timezone))
        \tRate limits: \(rateLimits)
        """
    }
}
