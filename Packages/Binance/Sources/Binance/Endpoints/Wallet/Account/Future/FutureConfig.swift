import Foundation

public struct FutureConfig: SnapshotRequestConfig {
    public typealias Response = FutureData
    public let type: AccountSnapshotType = .futures

    public init() {}
}
