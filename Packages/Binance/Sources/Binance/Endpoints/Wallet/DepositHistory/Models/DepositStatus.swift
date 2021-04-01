import Foundation

public enum DepositStatus: Codable {
    case pending, success, credited, other(Int)
    
    private struct Values {
        static let pending = 0
        static let success = 1
        static let credited = 6
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        switch value {
        case Values.pending: self = .pending
        case Values.success: self = .success
        case Values.credited: self = .credited
        default:
            // TODO: Log undhandled case
            self = .other(value)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    private var value: Int {
        switch self {
        case .pending: return Values.pending
        case .success: return Values.success
        case .credited: return Values.credited
        case .other(let value): return value
        }
    }
}
