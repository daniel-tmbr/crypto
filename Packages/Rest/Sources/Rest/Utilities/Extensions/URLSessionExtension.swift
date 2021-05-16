import Combine
import Foundation

public extension URLSession {
    func responsePublisher<R>(request: R, input: R.Input) -> ResponsePublisher<R.Output>
    where R: Request {
        request.publisher(urlSession: self, input: input)
    }
}
