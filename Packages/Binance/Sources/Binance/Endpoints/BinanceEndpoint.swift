import Combine
import Foundation
import Rest

public struct BinanceEndpoint<Input, Output: Decodable>: TopLevelRequest {
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

    init<R: BinanceRequest>(_ request: R)
    where R.RequestDataType == Input,
          R.ResponseDataType == Output {
        self.init(request: request.apiRequest())
    }

    public func publisher<Upstream>(urlSession: URLSession, requestDataPublisher upstream: Upstream) -> ResponsePublisher<Output> where Upstream: Publisher, Self.Input == Upstream.Output, Upstream.Failure == Never {
        if let upstream = upstream as? AnyPublisher<Input, Never> {
            return makePublisher(urlSession, upstream)
        } else {
            return makePublisher(urlSession, upstream.eraseToAnyPublisher())
        }
    }
}

extension BinanceRequest {
    func binanceEndpoint() -> BinanceEndpoint<RequestDataType, ResponseDataType> {
        BinanceEndpoint(self)
    }
}
