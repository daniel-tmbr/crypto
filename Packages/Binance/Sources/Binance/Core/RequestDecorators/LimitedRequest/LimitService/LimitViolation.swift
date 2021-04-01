import Foundation

struct LimitViolation: Error {
    let category: Limitation.Category
    let restriction: Restriction
}
