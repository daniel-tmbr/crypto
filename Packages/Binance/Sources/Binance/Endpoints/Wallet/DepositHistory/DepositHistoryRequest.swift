// Fetch deposit history. GET /sapi/v1/capital/deposit/hisrec (HMAC SHA256)
// https://binance-docs.github.io/apidocs/spot/en/#deposit-history-supporting-network-user_data

import Foundation
import Rest

struct DepositHistoryRequest: BinanceRequest {
    typealias Input = DepositHistoryParams
    typealias Output = [Deposit]
    
    private let url: URL
    private let decoder: JSONDecoder

    init(baseUrl: URL = .binanceApiUrl,
         decoder: JSONDecoder = .binance) {
        self.url = baseUrl.appendingPathComponent("/sapi/v1/capital/deposit/hisrec")
        self.decoder = decoder
    }

    func assemble(from params: DepositHistoryParams) throws -> URLRequest {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else { throw RequestAssemblyError.malformedUrl(url) }

        components.queryItems = try QueryItemEncoder().encode(params)

        guard let finalUrl = components.url
            else { throw RequestAssemblyError.invalidComponents(components) }

        return URLRequest.get(url: finalUrl)
    }

    func parse(data: Data, response: URLResponse) throws -> [Deposit] {
        try decoder.decode(Output.self, from: data)
    }

    func apiRequest() -> BinanceApiRequest<Input, Output> {
        binanceApiRequest(security: .userData)
    }
}
