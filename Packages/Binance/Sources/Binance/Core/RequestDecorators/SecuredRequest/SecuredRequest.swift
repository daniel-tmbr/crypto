import CryptoKit
import Foundation
import Rest

@dynamicMemberLookup
struct SecuredRequest<R: Request>: Request {
    typealias Input = R.Input
    typealias Output = R.Output
    
    private let request: R
    private let apiKeyReader: ApiSecurityKeyReader
    private let apiSecretReader: ApiSecurityKeyReader
    private let signer: Signer
    private let date: () -> Date
    private let lifespan: TimeInterval
    
    let security: SecurityType
    
    init(
        request: R,
        security: SecurityType,
        apiKeyReader: ApiSecurityKeyReader,
        apiSecretReader: ApiSecurityKeyReader,
        signer: Signer,
        date: @escaping @autoclosure () -> Date = Date(),
        lifespan: TimeInterval = 5
    ) {
        self.request = request
        self.security = security
        self.apiKeyReader = apiKeyReader
        self.apiSecretReader = apiSecretReader
        self.signer = signer
        self.date = date
        self.lifespan = lifespan
    }
    
    func assemble(from data: Input) throws -> URLRequest {
        var urlRequest = try request.assemble(from: data)
        switch security {
        case .trade, .margin, .userData:
            try sign(urlRequest: &urlRequest)
            fallthrough
        case .marketData, .userStream:
            try addApiKey(to: &urlRequest)
        case .none: break
        }
        return urlRequest
    }
    
    func parse(data: Data, response: URLResponse) throws -> Output {
        try request.parse(data: data, response: response)
    }
    
    private func addApiKey(to urlRequest: inout URLRequest) throws {
        guard let key = try apiKeyReader.read()
            else { throw SigningError.apiKeyMissing }
        urlRequest.addHeaderField(ApiKey(value: key))
    }
    
    private func sign(urlRequest: inout URLRequest) throws {
        guard let secret = try apiSecretReader.read()
            else { throw SigningError.apiSecretMissing }
        guard let url = urlRequest.url
            else { throw SigningError.missingUrl }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else { throw SigningError.malformedUrl(url) }
        
        let signingParams = SigningParams(
            timestamp: date().timeIntervalSince1970.toMilliseconds(),
            recvWindow: lifespan.toMilliseconds()
        )
        var queryContainer = URLQueryItemContainer(queryItems: components.queryItems ?? [])
        components.queryItems = try QueryItemEncoder(container: queryContainer).encode(signingParams)
        
        guard var signingContent = components.query
            else { throw SigningError.queryIsEmpty(components) }
        
        if let httpBody = urlRequest.httpBody {
            guard let body = String(bytes: httpBody, encoding: .utf8)
                else { throw SigningError.malformedBody(httpBody) }
            signingContent.append(contentsOf: body)
        }
        
        let signature = Signature(
            signature: try signer.sign(value: signingContent, with: secret)
        )
        queryContainer = URLQueryItemContainer(queryItems: components.queryItems ?? [])
        components.queryItems = try QueryItemEncoder(container: queryContainer).encode(signature)

        guard let finalUrl = components.url
            else { throw SigningError.invalidComponents(components) }
        
        urlRequest.url = finalUrl
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<R, T>) -> T {
        request[keyPath: keyPath]
    }
}

extension Request {
    func signed(security: SecurityType = .none,
                apiKeyReader: ApiSecurityKeyReader = SecureStringStore.binanceApiKey,
                apiSecretReader: ApiSecurityKeyReader = SecureStringStore.binanceApiSecret,
                signer: Signer = HmacSigner(),
                date: @escaping @autoclosure () -> Date = Date(),
                lifespan: TimeInterval = 5) -> SecuredRequest<Self> {
        SecuredRequest(
            request: self,
            security: security,
            apiKeyReader: apiKeyReader,
            apiSecretReader: apiSecretReader,
            signer: signer,
            date: date(),
            lifespan: lifespan
        )
    }
}
