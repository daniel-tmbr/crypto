import Foundation
import Rest

struct BinanceApiRequest<RequestData, ResponseData: Decodable>: Request {
    typealias Input = RequestData
    typealias Output = ResponseData
    
    private let request: AnyRequest<RequestData, ResponseData>
    private let decoder: JSONDecoder
    
    init<R: Request>(request: R,
                     limitCategory: Limitation.Category = .weight,
                     weight: UInt = 1,
                     security: SecurityType = .none,
                     decoder: JSONDecoder = .binance)
    where R.RequestDataType == RequestData,
          R.ResponseDataType == ResponseData {
        self.request = request
            .limited(category: limitCategory, weight: weight)
            .signed(security: security)
            .ereaseToAnyRequest()
        self.decoder = decoder
    }
    
    func assemble(from data: RequestData) throws -> URLRequest {
        try request.assemble(from: data)
    }
    
    func parse(data: Data, response: URLResponse) throws -> ResponseData {
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
                           decoder: JSONDecoder = .binance) -> BinanceApiRequest<RequestDataType, ResponseDataType> {
        BinanceApiRequest(
            request: self,
            limitCategory: limitCategory,
            weight: weight,
            security: security,
            decoder: decoder
        )
    }
}

