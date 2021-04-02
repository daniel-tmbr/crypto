import Combine
import Foundation

public protocol Request {
    associatedtype RequestDataType
    associatedtype ResponseDataType: Decodable
    func assemble(from data: RequestDataType) throws -> URLRequest
    func parse(data: Data, response: URLResponse) throws -> ResponseDataType
}

extension Request {
    public func publisher<Upstream>(requestDataPublisher upstream: Upstream,
                                    urlSession: URLSession) -> ResponsePublisher<ResponseDataType>
    where Upstream: Publisher,
          Upstream.Output == RequestDataType,
          Upstream.Failure == Never
    {
        ResponsePublisher(urlSession: urlSession, request: self, requestDataPublisher: upstream)
    }
    
    public func publisher(parameters: RequestDataType, urlSession: URLSession = .shared) -> ResponsePublisher<ResponseDataType> {
        publisher(requestDataPublisher: Just(parameters), urlSession: urlSession)
    }
}

extension Request where RequestDataType == Void {
    public func publisher(urlSession: URLSession = .shared) -> ResponsePublisher<ResponseDataType> {
        publisher(parameters: (), urlSession:  urlSession)
    }
}
