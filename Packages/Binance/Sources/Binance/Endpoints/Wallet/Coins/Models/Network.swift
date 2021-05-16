import Foundation

public struct Network: Decodable {
    public let addressRegex: String
    public let coin: Asset
    /// shown only when "depositEnable" is false.
    public let depositDesc: String?
    public let depositEnable: Bool
    public let insertTime: TimeInterval?
    public let isDefault: Bool
    public let memoRegex: String
    public let name: String
    public let network: Asset
    public let resetAddressStatus: Bool
    public let specialTips: String?
    public let updateTime: TimeInterval?
    /// shown only when "withdrawEnable" is false.
    public let withdrawDesc: String?
    public let withdrawEnable: Bool
    public let withdrawFee: BinanceDouble
    public let withdrawIntegerMultiple: BinanceDouble?
    public let withdrawMin: BinanceDouble
    
    public var description: String {
        "\(String(describing: Self.self)): \(name) (\(coin.value)"
    }
}
