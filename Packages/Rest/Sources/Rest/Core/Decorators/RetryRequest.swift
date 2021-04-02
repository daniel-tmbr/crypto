import Combine
import Foundation

public struct RetryRequest<R: Request>: TopLevelRequest {
    public typealias Input = R.RequestDataType
    public typealias Output = R.ResponseDataType
    public typealias Condition = (_ error: RequestError, _ retries: Int) -> Bool
    
    private let urlSession: URLSession
    private let request: R
    private let condition: Condition

    public init(urlSession: URLSession,
                request: R,
                condition: @escaping Condition) {
        self.urlSession = urlSession
        self.request = request
        self.condition = condition
    }
    
    public func publisher<Upstream>(requestDataPublisher upstream: Upstream,
                                    urlSession: URLSession) -> ResponsePublisher<Output>
    where Upstream: Publisher,
          Upstream.Output == Input,
          Upstream.Failure == Never
    {
        var retries = 0
        let responsePublisher = request.publisher(requestDataPublisher: upstream, urlSession: urlSession)
        let retryPublisher = responsePublisher
            .tryCatch { requestError -> ResponsePublisher<Output> in
                if condition(requestError, retries) {
                    retries += 1
                    return responsePublisher
                } else {
                    throw requestError
                }
            }
            .mapError { $0 as! RequestError }
        return ResponsePublisher(wrap: retryPublisher)
    }
}
