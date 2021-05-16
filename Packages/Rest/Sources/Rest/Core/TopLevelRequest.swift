import Combine
import Foundation

public protocol TopLevelRequest {
    associatedtype Input
    associatedtype Output: Decodable
    
    func publisher<Upstream>(urlSession: URLSession, requestDataPublisher upstream: Upstream) -> ResponsePublisher<Output>
    where Upstream: Publisher, Upstream.Output == Input, Upstream.Failure == Never
}

public extension TopLevelRequest {
    func publisher<Upstream>(requestDataPublisher upstream: Upstream) -> ResponsePublisher<Output>
    where Upstream: Publisher, Upstream.Output == Input, Upstream.Failure == Never {
        publisher(urlSession: .shared, requestDataPublisher: upstream)
    }
    
    func publisher(urlSession: URLSession = .shared, input: Input) -> ResponsePublisher<Output> {
        publisher(urlSession: urlSession, requestDataPublisher: Just(input))
    }
}

public extension TopLevelRequest where Self.Input == Void {
    func publisher(urlSession: URLSession = .shared) -> ResponsePublisher<Output> {
        publisher(urlSession: urlSession, requestDataPublisher: Just(()))
    }
}
