import Combine
import Foundation

public protocol TopLevelRequest {
    associatedtype Input
    associatedtype Output: Decodable
    
    func publisher<Upstream>(requestDataPublisher upstream: Upstream, urlSession: URLSession) -> ResponsePublisher<Output>
    where Upstream: Publisher, Upstream.Output == Input, Upstream.Failure == Never
}

public extension TopLevelRequest {
    func publisher<Upstream>(requestDataPublisher upstream: Upstream) -> ResponsePublisher<Output>
    where Upstream: Publisher, Upstream.Output == Input, Upstream.Failure == Never {
        publisher(requestDataPublisher: upstream, urlSession: .shared)
    }
    
    func publisher(input: Input) -> ResponsePublisher<Output> {
        publisher(requestDataPublisher: Just(input))
    }
}
