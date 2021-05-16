import Combine
import Foundation
import Rest

public struct BinanceEndpoint<Input, Output: Decodable>: TopLevelRequest {
    private let makePublisher: (URLSession, AnyPublisher<Input, Never>) -> ResponsePublisher<Output>
    
    init<R: TopLevelRequest>(request: R)
    where R.Input == Input,
          R.Output == Output {
        makePublisher = { urlSession, upstream in
            request.publisher(
                urlSession: urlSession,
                requestDataPublisher: upstream
            )
        }
    }

    init<R: BinanceRequest>(binanceRequest: R)
    where R.Input == Input,
          R.Output == Output {
        self.init(request: binanceRequest.apiRequest())
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
    func binanceEndpoint() -> BinanceEndpoint<Self.Input, Self.Output> {
        BinanceEndpoint(binanceRequest: self)
    }
}
