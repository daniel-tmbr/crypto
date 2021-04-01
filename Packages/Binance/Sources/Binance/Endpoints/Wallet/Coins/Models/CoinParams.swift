import Foundation

public struct CoinParams: Encodable {
    public let timestamp: TimeInterval?
    public let recvWindow: TimeInterval?

    public init(timestamp: TimeInterval? = nil,
                recvWindow: TimeInterval? = nil) {
        self.timestamp = timestamp
        self.recvWindow = recvWindow
    }
}
