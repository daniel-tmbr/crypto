import Foundation

public enum Authorization: HttpHeaderField {
    case basic(String)
    case bearer(String)

    private static let headerKey = "Authorization"
    public var key: String { Self.headerKey }
    public var value: String {
        switch self {
        case .basic(let token): return "Basic \(token)"
        case .bearer(let token): return "Bearer \(token)"
        }
    }
}
