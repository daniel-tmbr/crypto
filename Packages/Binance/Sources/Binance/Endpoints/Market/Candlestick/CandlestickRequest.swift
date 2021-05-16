// Exchange Information: GET /api/v3/klines
// https://binance-docs.github.io/apidocs/spot/en/#kline-candlestick-data

import Foundation
import Rest

struct CandlestickRequest: BinanceRequest {
    typealias Input = CandlestickParams
    typealias Output = [Candlestick]
    
    private let url: URL
    private let decoder: JSONDecoder
    
    init(baseUrl: URL = .binanceApiUrl,
         decoder: JSONDecoder = .binance) {
        self.url = baseUrl.appendingPathComponent("/api/v3/klines")
        self.decoder = decoder
    }
    
    func assemble(from params: CandlestickParams) throws -> URLRequest {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else { throw RequestAssemblyError.malformedUrl(url) }
        
        components.queryItems = try QueryItemEncoder().encode(params)
        
        guard let finalUrl = components.url
        else { throw RequestAssemblyError.invalidComponents(components) }
        
        return URLRequest.get(url: finalUrl)
    }
    
    func parse(data: Data, response: URLResponse) throws -> [Candlestick] {
        try decoder.decode(Output.self, from: data)
    }

    func apiRequest() -> BinanceApiRequest<CandlestickParams, [Candlestick]> {
        binanceApiRequest()
    }
}
