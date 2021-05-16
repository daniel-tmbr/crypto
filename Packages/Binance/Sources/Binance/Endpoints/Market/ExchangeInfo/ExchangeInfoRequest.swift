// Exchange Information: GET /api/v3/exchangeInfo
// https://binance-docs.github.io/apidocs/spot/en/#exchange-information

import Foundation
import Rest

struct ExchangeInfoRequest: BinanceRequest {
    typealias Input = Void
    typealias Output = ExchangeInfo
    
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
        try decoder.decode(Output.self, from: data)
    }

    func apiRequest() -> BinanceApiRequest<Void, ExchangeInfo> {
        binanceApiRequest()
    }
}
