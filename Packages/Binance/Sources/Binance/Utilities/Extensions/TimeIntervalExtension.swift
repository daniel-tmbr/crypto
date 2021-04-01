import Foundation

extension TimeInterval {
    static let lifespan: TimeInterval = 5

    func toMilliseconds() -> Int {
        Int((self * 1000).rounded())
    }
    
    func fromMilliseconds() -> TimeInterval {
        self / 1000
    }
}
