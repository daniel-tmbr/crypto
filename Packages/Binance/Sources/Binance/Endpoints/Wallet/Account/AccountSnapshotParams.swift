import Foundation

public struct AccountSnapshotParams: Encodable {
    public let startTime: TimeInterval?
    public let endTime: TimeInterval?
    ///  min 5, max 30, default 5
    public let limit: Int?

    public init(startTime: TimeInterval? = nil,
                endTime: TimeInterval? = nil,
                limit: Int? = nil) {
        self.startTime = startTime
        self.endTime = endTime
        self.limit = limit
    }
}
