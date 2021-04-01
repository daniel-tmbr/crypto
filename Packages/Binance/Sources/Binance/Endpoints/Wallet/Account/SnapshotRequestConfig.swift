import Foundation

public protocol SnapshotRequestConfig {
    associatedtype Response: Decodable
    var type: AccountSnapshotType { get }
}
