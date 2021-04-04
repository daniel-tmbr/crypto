// Daily Account Snapshot: GET /sapi/v1/accountSnapshot (HMAC SHA256)
// https://binance-docs.github.io/apidocs/spot/en/#daily-account-snapshot-user_data

import Foundation
import Rest

struct AccountSnapshotRequest<SnapshotConfig>: BinanceRequest where SnapshotConfig: SnapshotRequestConfig {
    private let url: URL
    private let config: SnapshotConfig
    private let decoder: JSONDecoder
    
    init(baseUrl: URL = .binanceApiUrl,
         config: SnapshotConfig,
         decoder: JSONDecoder = .binance) {
        self.url = baseUrl.appendingPathComponent("/sapi/v1/accountSnapshot")
        self.config = config
        self.decoder = decoder
    }
    
    func assemble(from params: AccountSnapshotParams) throws -> URLRequest {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else { throw RequestAssemblyError.malformedUrl(url) }
        
        components.queryItems = (try QueryItemEncoder().encode(config.type)) + (try QueryItemEncoder().encode(params))
        
        guard let finalUrl = components.url
        else { throw RequestAssemblyError.invalidComponents(components) }
        
        return URLRequest.get(url: finalUrl)
    }
    
    func parse(data: Data, response: URLResponse) throws -> AccountSnapshot<SnapshotConfig.Response> {
        try decoder.decode(ResponseDataType.self, from: data)
    }

    func apiRequest() -> BinanceApiRequest<RequestDataType, ResponseDataType> {
        binanceApiRequest(security: .userData)
    }
}
