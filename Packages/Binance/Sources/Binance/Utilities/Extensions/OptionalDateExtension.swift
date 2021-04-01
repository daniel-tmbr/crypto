import Foundation

extension Optional where Wrapped == TimeInterval {
    func date() -> Date {
        switch self {
        case .none: return Date()
        case .some(let interval): return Date(timeIntervalSince1970: interval)
        }
    }
}
