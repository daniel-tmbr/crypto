import Foundation

public enum OrderStatus: Decodable {
    /// The order has been accepted by the engine.
    case new

    /// A part of the order has been filled.
    case partiallyFilled

    /// The order has been completely filled.
    case filled

    /// The order has been canceled by the user.
    case cancelled

    /// **Warning:** currently unused
    case pendingCancel

    /// The order was not accepted by the engine and not processed.
    case rejected

    /// The order was canceled according to the order type's rules (e.g. LIMIT FOK orders with no fill, LIMIT IOC or MARKET orders that partially fill)
    /// or by the exchange, (e.g. orders canceled during liquidation, orders canceled during maintenance)
    case expired

    /// Fallback for future changes
    case other(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case Raw.new: self = .new
        case Raw.partiallyFilled: self = .partiallyFilled
        case Raw.filled: self = .filled
        case Raw.cancelled: self = .cancelled
        case Raw.pendingCancel: self = .pendingCancel
        case Raw.rejected: self = .rejected
        case Raw.expired: self = .expired
        default: self = .other(value)
        }
    }

    private struct Raw {
        static let new = "NEW"
        static let partiallyFilled = "PARTIALLY_FILLED"
        static let filled = "FILLED"
        static let cancelled = "CANCELED"
        static let pendingCancel = "PENDING_CANCEL"
        static let rejected = "REJECTED"
        static let expired = "EXPIRED"
    }
}
