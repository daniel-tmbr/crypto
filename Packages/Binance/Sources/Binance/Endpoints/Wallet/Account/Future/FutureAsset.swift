import Foundation

public struct FutureAsset: Decodable {
    public let asset: Asset
    public let marginBalance: Double
    public let walletBalance: Double
}
