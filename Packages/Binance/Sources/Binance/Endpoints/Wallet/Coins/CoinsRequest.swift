// All coins information: GET /sapi/v1/capital/config/getall (HMAC SHA256)
// https://binance-docs.github.io/apidocs/spot/en/#all-coins-39-information-user_data

import Foundation
import Rest

struct CoinsRequest: BinanceRequest {
    typealias Input = CoinParams
    typealias Output = [Coin]
    
    private let url: URL
    private let decoder: JSONDecoder

    init(baseUrl: URL = .binanceApiUrl,
         decoder: JSONDecoder = .binance) {
        self.url = baseUrl.appendingPathComponent("/sapi/v1/capital/config/getall")
        self.decoder = decoder
    }

    func assemble(from params: CoinParams) throws -> URLRequest {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else { throw RequestAssemblyError.malformedUrl(url) }
        components.queryItems = try QueryItemEncoder().encode(params)
        guard let finalUrl = components.url
            else { throw RequestAssemblyError.invalidComponents(components) }
        return URLRequest.get(url: finalUrl)
    }

    func parse(data: Data, response: URLResponse) throws -> [Coin] {
        try decoder.decode(Output.self, from: data)
    }

    func apiRequest() -> BinanceApiRequest<Input, Output> {
        logged { (logger, _, _) in
            logger.debug("Coins response is parsing")
        } parseErrorLogging: { (logger, error, _ , _) in
            logger.debug("Coins response parsing has failed")
        }
        .binanceApiRequest(security: .userData)
    }
}
