import Foundation

public struct DepositHistoryParams: Encodable {
    public let coin: Asset?
    public let status: DepositStatus?
    /// Default: 90 days from current timestamp
    public let startTime: TimeInterval?
    /// Default: present timestamp
    public let endTime: TimeInterval?
    /// Default:  0
    public let offest: Int?
    public let timestamp: TimeInterval?
    public let recvWindow: TimeInterval?

    public init(
        coin: Asset? = nil,
        status: DepositStatus? = nil,
        startTime: TimeInterval? = nil,
        endTime: TimeInterval? = nil,
        offest: Int? = nil,
        timestamp: TimeInterval? = nil,
        recvWindow: TimeInterval? = nil
    ) {
        self.coin = coin
        self.status = status
        self.startTime = startTime
        self.endTime = endTime
        self.offest = offest
        self.timestamp = timestamp
        self.recvWindow = recvWindow
    }
}
