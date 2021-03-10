import Foundation

extension URLRequest {
    public init(url: URL,
                cachePolicy: CachePolicy,
                timeoutInterval: TimeInterval,
                contentType: ContentType = .json,
                httpMethod: HttpMethod = .get) {
        self.init(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        self.httpMethod = httpMethod.rawValue
        addHeaderField(contentType)
    }
    
    public static func get(url: URL,
                           cachePolicy: CachePolicy = .default,
                           timeoutInterval: TimeInterval = .timeout,
                           contentType: ContentType = .json) -> URLRequest {
        URLRequest(
            url: url,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval,
            contentType: contentType,
            httpMethod: .get
        )
    }
    
    public static func post(url: URL,
                            cachePolicy: CachePolicy = .default,
                            timeoutInterval: TimeInterval = .timeout,
                            contentType: ContentType = .json) -> URLRequest {
        URLRequest(
            url: url,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval,
            contentType: contentType,
            httpMethod: .post
        )
    }
    
    public mutating func addHeaderField(_ field: HttpHeaderField) {
        setValue(field.value, forHTTPHeaderField: field.key)
    }
    
    public mutating func addHeaderFields(_ fields: [HttpHeaderField]) {
        fields.forEach { addHeaderField($0) }
    }
}
