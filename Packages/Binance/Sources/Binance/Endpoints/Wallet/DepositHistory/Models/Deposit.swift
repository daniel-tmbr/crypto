import Foundation

public struct Deposit: Decodable {
    public let address: String
    public let addressTag: String
    public let amount: Double
    public let coin: Asset
    public let insertTime: TimeInterval // 1566791463000
    public let network: Asset
    public let status: DepositStatus
    public let txId: String
}
