import Foundation

public struct Coin: Decodable, CustomStringConvertible {
    public let coin: Asset
    public let depositAllEnable: Bool
    public let free: BinanceDouble
    public let freeze: BinanceDouble
    public let ipoable: BinanceDouble
    public let ipoing: BinanceDouble
    public let isLegalMoney: Bool
    public let locked: BinanceDouble
    public let name: String
    public let networkList: [Network]
    public let storage: BinanceDouble
    public let trading: Bool
    public let withdrawAllEnable: Bool
    public let withdrawing: BinanceDouble
    
    public var description: String {
        "\(String(describing: Self.self)): \(name) (\(coin.value))"
    }
}
