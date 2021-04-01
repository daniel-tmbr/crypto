import Combine
import Foundation
import Rest

protocol LimitService {
    func validate<R>(request: R) throws where R: Request, R: Limited
    func executed<R>(request: R) where R: Request, R: Limited
    func handle(violation: LimitViolation)
}

final class ApiLimitService: LimitService {
    typealias Category = Limitation.Category
    
    private struct ExecutedRequest: Limited {
        let category: Category
        let weight: UInt
        let date: Date
        
        init(category: Category, weight: UInt, date: Date = Date()) {
            self.category = category
            self.weight = weight
            self.date = date
        }
    }
    
    // TODO: Get this from ExchangeInfo endpoint
    private var limitations: [Limitation] = Limitation.limitations
    private var limitViolations: [Category: LimitViolation] = [:]
    private var executedRequests: [ExecutedRequest] = []
        
    static let shared = ApiLimitService()
    private init() {}
    
    func validate<R>(request: R) throws
    where R: Request, R: Limited {
        try checkViolations(with: request)
        
        let now = Date()
        let requests = executedRequests.lazy
            .reversed()
            .filter { request.category.contains($0.category) }
        
        try limitations.forEach { limitation in
            try validate(
                request: request,
                executedRequests: requests,
                limitation: limitation,
                date: now
            )
        }
    }

    func executed<R>(request: R)
    where R: Request, R: Limited {
        executedRequests.append(
            ExecutedRequest(category: request.category, weight: request.weight)
        )
    }
    
    func handle(violation: LimitViolation) {
        limitViolations[violation.category] = violation
    }
    
    private func checkViolations<R>(with request: R) throws
    where R: Request, R: Limited {
        if let violation = limitViolations.first(where: {
            request.category.contains($0.key) && $0.value.restriction.isValid()
        }) {
            throw violation.value
        }
    }
        
    private func validate<R>(
        request: R,
        executedRequests requests: SortedFilteredRequests,
        limitation: Limitation,
        date: Date = Date()
    ) throws where R: Request, R: Limited {
        guard request.category.contains(limitation.category) else { return }
        
        var summs: [UInt] = Array(repeating: 0, count: limitation.limits.count)
        var activeLimits = limitation.limits
        
        try requests.forEach { req in
            let amount = limitation.calculate(req)
            try activeLimits.enumerated().forEach { (index, limit) in
                let interval = req.date.addingTimeInterval(limit.interval).timeIntervalSince(date)
                guard interval > 0 else {
                    activeLimits.remove(at: index)
                    return
                }
                guard summs[index] + amount < limit.amount else {
                    let violation = LimitViolation(
                        category: limitation.category,
                        restriction: Restriction(type: .blocked, duration: interval)
                    )
                    handle(violation: violation)
                    throw violation
                }
                summs[index] += amount
            }
        }
    }
    
    private typealias SortedFilteredRequests = LazyFilterSequence<ReversedCollection<LazySequence<[ExecutedRequest]>>.Elements>
}
