import Foundation

public struct SpotConfig: SnapshotRequestConfig {
    public typealias Response = SpotData
    public let type: AccountSnapshotType = .spot

    public init() {}
}
