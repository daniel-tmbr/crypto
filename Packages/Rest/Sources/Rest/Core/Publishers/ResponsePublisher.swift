import Combine
import Foundation

public struct ResponsePublisher<Response: Decodable>: Publisher {
    public typealias Output = Response
    public typealias Failure = RequestError
    
    private let publisher: AnyPublisher<Response, RequestError>
    
    public init<R: Request, Upstream: Publisher>(
        urlSession: URLSession,
        request: R,
        requestDataPublisher: Upstream
    )
    where R.Output == Response,
          Upstream.Output == R.Input,
          Upstream.Failure == Never
    {
        publisher = requestDataPublisher
            .tryMap(request.assemble)
            .mapError { RequestError(error: $0, category: .compose) }
            .map {
                urlSession
                    .dataTaskPublisher(for: $0)
                    .mapError(RequestError.init(urlError:))
                    .tryMap(request.parse)
                    .mapError { RequestError(error: $0, category: .response) }
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
    
    public init<R: Request>(
        urlSession: URLSession,
        request: R,
        requestData: R.Input
    )
    where R.Output == Response
    {
        self.init(
            urlSession: urlSession,
            request: request,
            requestDataPublisher: Just(requestData)
        )
    }
    
    public init(anyPublisher: AnyPublisher<Response, RequestError>) {
        publisher = anyPublisher
    }
    
    public init<Upstream: Publisher>(wrap upstream: Upstream)
    where Upstream.Output == Output,
          Upstream.Failure == Failure
    {
        self.init(anyPublisher: upstream.eraseToAnyPublisher())
    }
        
    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        publisher.subscribe(subscriber)
    }
}
