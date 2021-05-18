// System status: GET /wapi/v3/systemStatus.html
// https://binance-docs.github.io/apidocs/spot/en/#system-status-system

import Foundation
import Rest

struct SystemStatusRequest: BinanceRequest {
    private let baseUrl: URL
    private let decoder: JSONDecoder

    init(baseUrl: URL = .binanceApiUrl,
         decoder: JSONDecoder = .binance) {
        self.baseUrl = baseUrl
        self.decoder = decoder
    }

    func assemble(from data: Void) throws -> URLRequest {
        let url = baseUrl.appendingPathComponent("/wapi/v3/systemStatus.html")
        return URLRequest(
            url: url,
            cachePolicy: .default,
            timeoutInterval: .timeout
        )
    }

    func parse(data: Data, response: URLResponse) throws -> SystemStatus {
        return try decoder.decode(SystemStatus.self, from: data)
    }

    func apiRequest() -> BinanceApiRequest<Void, SystemStatus> {
        binanceApiRequest()
    }
}
