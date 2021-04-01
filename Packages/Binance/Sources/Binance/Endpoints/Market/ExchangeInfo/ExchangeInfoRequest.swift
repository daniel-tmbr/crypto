// Exchange Information: GET /api/v3/exchangeInfo
// https://binance-docs.github.io/apidocs/spot/en/#exchange-information

import Foundation
import Rest

struct ExchangeInfoRequest: Request {
    private let url: URL
    private let decoder: JSONDecoder
    
    init(baseUrl: URL = .binanceApiUrl,
         decoder: JSONDecoder = .binance) {
        self.url = baseUrl.appendingPathComponent("/api/v3/exchangeInfo")
        self.decoder = decoder
    }
    
    func assemble(from: Void) throws -> URLRequest {
        URLRequest.get(url: url)
    }
    
    func parse(data: Data, response: URLResponse) throws -> ExchangeInfo {
        try decoder.decode(ResponseDataType.self, from: data)
    }
}

extension ExchangeInfoRequest: BinanceApiRequest {
    func binanceApiRequest() -> BinanceRequest<RequestDataType, ResponseDataType> {
        binanceRequest()
    }
}
