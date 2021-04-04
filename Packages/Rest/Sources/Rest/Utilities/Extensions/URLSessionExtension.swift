import Combine
import Foundation

public extension URLSession {
    func responsePublisher<R>(request: R, parameters: R.RequestDataType) -> ResponsePublisher<R.ResponseDataType>
    where R: Request {
        request.publisher(urlSession: self, parameters: parameters)
    }
}
