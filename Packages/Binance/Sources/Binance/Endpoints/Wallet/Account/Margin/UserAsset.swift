import Foundation

public struct UserAsset: Decodable {
    public let asset: Asset
    public let borrowed: Double
    public let free: Double
    public let interest: Double
    public let locked: Double
    public let netAsset: Double
}
