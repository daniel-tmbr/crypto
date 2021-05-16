import Combine
import Foundation

public struct RetryRequest<Input, Output: Decodable>: TopLevelRequest {
    public typealias Condition = (_ error: RequestError, _ retries: Int) -> Bool
    
    private let request: AnyTopLevelRequest<Input, Output>
    private let condition: Condition
    
    public init<R: TopLevelRequest>(request: R, condition: @escaping Condition)
    where R.Input == Self.Input,
          R.Output == Self.Output
    {
        self.request = request.ereaseToAnyTopLevelRequest()
        self.condition = condition
    }
    
    public func publisher<Upstream>(urlSession: URLSession,
                                    requestDataPublisher upstream: Upstream) -> ResponsePublisher<Output>
    where Upstream: Publisher,
          Upstream.Output == Input,
          Upstream.Failure == Never
    {
        var retries = 0
        let responsePublisher = request.publisher(urlSession: urlSession, requestDataPublisher: upstream)
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

extension Request {
    public typealias RetryCondition = RetryRequest<Input, Output>.Condition
    public func retry(condition: @escaping RetryCondition) -> RetryRequest<Input, Output> {
        RetryRequest(request: self, condition: condition)
    }
}

extension TopLevelRequest {
    public typealias RetryCondition = RetryRequest<Input, Output>.Condition
    public func retry(condition: @escaping RetryCondition) -> RetryRequest<Input, Output> {
        RetryRequest(request: self, condition: condition)
    }
}
