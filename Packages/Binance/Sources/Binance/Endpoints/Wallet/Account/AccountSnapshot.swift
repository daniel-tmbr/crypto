import Foundation

public struct AccountSnapshot<SnapshotData: Decodable>: Decodable {
    public let code: Int
    public let msg: String
    public let snapshotVos: [Snapshot<SnapshotData>]
}

