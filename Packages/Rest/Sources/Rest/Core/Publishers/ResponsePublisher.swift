import Combine
import Foundation

public struct ResponsePublisher<Response: Decodable>: Publisher {
    public typealias Input = (data: Data, response: URLResponse)
    public typealias Parser = (Input) throws -> Response
    public typealias Output = Response
    public typealias Failure = RequestError
    
    private let upstream: AnyPublisher<Input, RequestError>
    private let parser: Parser
    
    init(upstream: AnyPublisher<Input, RequestError>, parser: @escaping Parser) {
        self.upstream = upstream
        self.parser = parser
    }
    
    init(upstream: AnyPublisher<Input, URLError>, parser: @escaping Parser) {
        let mappedUpstream = upstream
            .mapError(RequestError.init(urlError:))
            .eraseToAnyPublisher()
        self.init(upstream: mappedUpstream, parser: parser)
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        upstream
            .tryMap(parser)
            .mapError { RequestError(error: $0, category: .response) }
            .subscribe(subscriber)
    }
}

public extension Publisher where Output == (data: Data, response: URLResponse), Failure == URLError {
    func responsePublisher<Response: Decodable>(
        parser: @escaping (_ data: Data, _ response: URLResponse) throws -> Response
    ) -> ResponsePublisher<Response> {
        ResponsePublisher(upstream: self.eraseToAnyPublisher(), parser: parser)
    }
}

public extension Publisher where Output == (data: Data, response: URLResponse), Failure == RequestError {
    func responsePublisher<Response: Decodable>(
        parser: @escaping (_ data: Data, _ response: URLResponse) throws -> Response
    ) -> ResponsePublisher<Response> {
        ResponsePublisher(upstream: self.eraseToAnyPublisher(), parser: parser)
    }
}

