import Foundation

public struct Position: Decodable {
    public let entryPrice: Double
    public let markPrice: Double
    public let positionAmt: Double
    public let symbol: String
    public let unRealizedProfit: Double
}
