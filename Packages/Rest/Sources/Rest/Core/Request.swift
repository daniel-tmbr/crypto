import Combine
import Foundation

public protocol Request: TopLevelRequest {
    func assemble(from data: Input) throws -> URLRequest
    func parse(data: Data, response: URLResponse) throws -> Output
}

extension Request {
    public func publisher<Upstream>(urlSession: URLSession,
                                    requestDataPublisher upstream: Upstream) -> ResponsePublisher<Output>
    where Upstream: Publisher,
          Upstream.Output == Input,
          Upstream.Failure == Never
    {
        ResponsePublisher(urlSession: urlSession, request: self, requestDataPublisher: upstream)
    }
}
