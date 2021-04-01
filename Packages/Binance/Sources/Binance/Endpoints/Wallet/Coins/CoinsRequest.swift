// All coins information: GET /sapi/v1/capital/config/getall (HMAC SHA256)
// https://binance-docs.github.io/apidocs/spot/en/#all-coins-39-information-user_data

import Foundation
import Rest

struct CoinsRequest: Request {
    private let url: URL
    private let decoder: JSONDecoder

    init(baseUrl: URL = .binanceApiUrl,
         decoder: JSONDecoder = .binance) {
        self.url = baseUrl.appendingPathComponent("/sapi/v1/capital/config/getall")
        self.decoder = decoder
    }

    func assemble(from params: CoinParams) throws -> URLRequest {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else { throw RequestAssemblyError.components(url) }
        components.queryItems = try QueryItemEncoder().encode(params)
        guard let finalUrl = components.url
            else { throw RequestAssemblyError.composeUrl(components) }
        return URLRequest.get(url: finalUrl)
    }

    func parse(data: Data, response: URLResponse) throws -> [Coin] {
        try decoder.decode(ResponseDataType.self, from: data)
    }
}

extension CoinsRequest: BinanceApiRequest {
    func binanceApiRequest() -> BinanceRequest<RequestDataType, ResponseDataType> {
        binanceRequest(security: .userData)
    }
}
