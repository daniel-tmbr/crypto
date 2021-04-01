import Foundation

public struct MarginData: Decodable {
    public let marginLevel: Double
    public let totalAssetOfBtc: Double
    public let totalLiabilityOfBtc: Double
    public let totalNetAssetOfBtc: Double
    public let userAssets: [UserAsset]
}
