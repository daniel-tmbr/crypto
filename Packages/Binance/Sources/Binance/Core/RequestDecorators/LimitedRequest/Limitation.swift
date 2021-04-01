import Foundation
import Rest

protocol Limited {
    var category: Limitation.Category { get }
    var weight: UInt { get }
}

struct Limitation {
    struct Category: OptionSet, Hashable {
        let rawValue: UInt8
        static let api = Category(rawValue: 0b0000_0001)
        static let weight = Category(rawValue: 0b0000_0011)
        static let order = Category(rawValue: 0b0000_0101)
    }
    
    struct Limit {
        let amount: UInt
        let interval: TimeInterval
    }
    
    let category: Category
    let limits: [Limit]
    let calculate: (_ request: Limited) -> UInt
}

extension Limitation {
    // TODO: Get limitations from ExchangeInfo endpoint
    // RateLimit: orders; Limit: 100 per 10 second
    // RateLimit: orders; Limit: 200000 per 1 day
    // Set the limits to be 85% of the actual ones
    static let limitations: [Limitation] = [
        Limitation(
            category: .weight,
            limits: [
                Limit(amount: UInt(1_200 * 0.85), interval: 60),
            ],
            calculate: { $0.weight }
        ),
        Limitation(
            category: .order,
            limits: [
                Limit(amount: UInt(100 * 0.85), interval: 10),
                Limit(amount: UInt(200_000 * 0.85), interval: 1 * 60 * 60 * 24)
            ],
            calculate: { _ in 1 }
        ),
    ]
}
