import Foundation

public struct BalanceResponse: Decodable {
    public let asset: Asset
    public let free: Double
    public let locked: Double
}
