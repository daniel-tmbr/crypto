import Foundation

struct Restriction: Codable, Comparable {
    enum RestrictionType: Int, Codable {
        case banned
        case blocked
    }
    let type: RestrictionType
    let start: Date
    let duration: TimeInterval
    
    var end: Date {
        start.addingTimeInterval(duration)
    }
    
    init(type: RestrictionType,
         start: Date = Date(),
         duration: TimeInterval) {
        self.type = type
        self.start = start
        self.duration = duration
    }
    
    func isValid(on date: Date = Date()) -> Bool { end >= date }
    
    static func < (lhs: Self, rhs: Self) -> Bool { lhs.end < rhs.end }
    static func <= (lhs: Self, rhs: Self) -> Bool { lhs.end <= rhs.end }
    static func >= (lhs: Self, rhs: Self) -> Bool { lhs.end >= rhs.end }
}
