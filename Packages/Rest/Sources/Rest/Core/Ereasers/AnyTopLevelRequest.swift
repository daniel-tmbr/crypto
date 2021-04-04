import Combine
import Foundation

public struct AnyTopLevelRequest<Input, Output: Decodable>: TopLevelRequest {
    private let makePublisher: (URLSession, AnyPublisher<Input, Never>) -> ResponsePublisher<Output>
    
    init<R: Request>(request: R)
    where R.RequestDataType == Input,
          R.ResponseDataType == Output {
        makePublisher = { urlSession, upstream in
            request.publisher(
                urlSession: urlSession,
                requestDataPublisher: upstream
            )
        }
    }
    
    init<T: TopLevelRequest>(wrap request: T)
    where T.Input == Input,
          T.Output == Output
    {
        makePublisher = { urlSession, upstream in
            request.publisher(
                urlSession: urlSession,
                requestDataPublisher: upstream
            )
        }
    }

    public func publisher<Upstream>(urlSession: URLSession, requestDataPublisher upstream: Upstream) -> ResponsePublisher<Output> where Upstream: Publisher, Input == Upstream.Output, Upstream.Failure == Never {
        if let upstream = upstream as? AnyPublisher<Input, Never> {
            return makePublisher(urlSession, upstream)
        } else {
            return makePublisher(urlSession, upstream.eraseToAnyPublisher())
        }
    }
}

extension TopLevelRequest {
    public func ereaseToAnyTopLevelRequest() -> AnyTopLevelRequest<Input, Output> {
        AnyTopLevelRequest(wrap: self)
    }
}

extension Request {
    public func topLevelRequest() -> AnyTopLevelRequest<RequestDataType, ResponseDataType> {
        AnyTopLevelRequest(request: self)
    }
}
