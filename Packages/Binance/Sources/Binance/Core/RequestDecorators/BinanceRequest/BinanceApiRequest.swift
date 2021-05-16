import Foundation
import Rest

struct BinanceApiRequest<Input, Output: Decodable>: Request {
    private let request: AnyRequest<Input, Output>
    private let decoder: JSONDecoder
    
    init<R: Request>(request: R,
                     limitCategory: Limitation.Category = .weight,
                     weight: UInt = 1,
                     security: SecurityType = .none,
                     decoder: JSONDecoder = .binance)
    where R.Input == Input,
          R.Output == Output {
        self.request = request
            .limited(category: limitCategory, weight: weight)
            .signed(security: security)
            .ereaseToAnyRequest()
        self.decoder = decoder
    }
    
    func assemble(from data: Input) throws -> URLRequest {
        try request.assemble(from: data)
    }
    
    func parse(data: Data, response: URLResponse) throws -> Output {
        do {
            return try request.parse(data: data, response: response)
        } catch {
            if let binanceError = try? decoder.decode(BinanceError.self, from: data) {
                throw binanceError
            } else {
                throw error
            }
        }
    }
}

extension Request {
    func binanceApiRequest(limitCategory: Limitation.Category = .weight,
                           weight: UInt = 1,
                           security: SecurityType = .none,
                           decoder: JSONDecoder = .binance) -> BinanceApiRequest<Input, Output> {
        BinanceApiRequest(
            request: self,
            limitCategory: limitCategory,
            weight: weight,
            security: security,
            decoder: decoder
        )
    }
}

