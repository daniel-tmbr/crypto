import Foundation

public struct RateLimit: Codable, CustomStringConvertible {
    public let rateLimitType: RateLimitType
    public let interval: RateLimitInterval
    public let intervalNum: Int
    public let limit: Int
    
    public var description: String {
        """
        \(String(describing: Self.self)): \(rateLimitType)
        Limit: \(limit) per \(intervalNum) \(interval)
        """
    }
}
