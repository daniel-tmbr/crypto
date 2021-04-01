import Foundation

public struct SpotData: Decodable {
    public let balances: [BalanceResponse]
    public let totalAssetOfBtc: Double
}
