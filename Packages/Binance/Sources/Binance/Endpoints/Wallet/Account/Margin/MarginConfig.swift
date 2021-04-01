import Foundation

public struct MarginConfig: SnapshotRequestConfig {
    public typealias Response = MarginData
    public let type: AccountSnapshotType = .margin

    public init() {}
}
