import Foundation
import Rest

@dynamicMemberLookup
struct LimitedRequest<R: Request>: Request, Limited {
    typealias Input = R.Input
    typealias Output = R.Output
    
    private let request: R
    private let limitService: LimitService
    private let decoder: JSONDecoder
    
    let category: Limitation.Category
    let weight: UInt
    
    init(
        request: R,
        category: Limitation.Category,
        weight: UInt,
        limitService: LimitService,
        decoder: JSONDecoder = .binance
    ) {
        self.request = request
        self.category = category
        self.weight = weight
        self.limitService = limitService
        self.decoder = decoder
    }
    
    func assemble(from data: Input) throws -> URLRequest {
        try limitService.validate(request: self)
        return try request.assemble(from: data)
    }
    
    func parse(data: Data, response: URLResponse) throws -> Output {
        if let httpResponse = response as? HTTPURLResponse,
           let error = try? decoder.decode(BinanceError.self, from: data),
           let violation = limitViolation(from: error, headers: httpResponse.allHeaderFields) {
            limitService.handle(violation: violation)
            throw violation
        } else {
            return try request.parse(data: data, response: response)
        }
    }
    
    private func limitViolation(from error: BinanceError, headers: [AnyHashable : Any]) -> LimitViolation? {
        // TODO: GET DURATION FROM HEADER
        switch error.code {
        case .rateLimitViolation:
            return LimitViolation(
                category: .api,
                restriction: Restriction(type: .blocked, duration: 60 * 60)
            )
        case .wafLimitViolation:
            return LimitViolation(
                category: .api,
                restriction: Restriction(type: .blocked, duration: 60 * 60)
            )
        case .banned:
            return LimitViolation(
                category: .api,
                restriction: Restriction(type: .banned, duration: 60 * 60)
            )
        default:
            return nil
        }
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<R, T>) -> T {
        request[keyPath: keyPath]
    }
}

extension Request {
    func limited(category: Limitation.Category = .weight,
                 weight: UInt = 1,
                 limitService: LimitService = ApiLimitService.shared,
                 decoder: JSONDecoder = .binance) -> LimitedRequest<Self> {
        LimitedRequest(
            request: self,
            category: category,
            weight: weight,
            limitService: limitService,
            decoder: decoder
        )
    }
}
