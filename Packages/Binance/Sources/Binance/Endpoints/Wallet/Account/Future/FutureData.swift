import Foundation

public struct FutureData: Decodable {
    public let assets: [FutureAsset]
    public let position: [Position]
}
