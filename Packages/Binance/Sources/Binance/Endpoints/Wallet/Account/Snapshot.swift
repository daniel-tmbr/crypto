import Foundation

public struct Snapshot<SnapshotData: Decodable>: Decodable {
    public let data: SnapshotData
    public let type: AccountSnapshotType
    public let updateTime: TimeInterval
}
