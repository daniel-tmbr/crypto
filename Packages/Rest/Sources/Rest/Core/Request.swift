import Combine
import Foundation

public protocol Request {
    associatedtype RequestDataType
    associatedtype ResponseDataType: Decodable
    func assemble(from data: RequestDataType) throws -> URLRequest
    func parse(data: Data, response: URLResponse) throws -> ResponseDataType
}

extension Request {
    public func publisher<Upstream>(urlSession: URLSession,
                                    requestDataPublisher upstream: Upstream) -> ResponsePublisher<ResponseDataType>
    where Upstream: Publisher,
          Upstream.Output == RequestDataType,
          Upstream.Failure == Never
    {
        ResponsePublisher(urlSession: urlSession, request: self, requestDataPublisher: upstream)
    }
    
    public func publisher(urlSession: URLSession = .shared, parameters: RequestDataType) -> ResponsePublisher<ResponseDataType> {
        publisher(urlSession: urlSession, requestDataPublisher: Just(parameters))
    }
}

extension Request where RequestDataType == Void {
    public func publisher(urlSession: URLSession = .shared) -> ResponsePublisher<ResponseDataType> {
        publisher(urlSession:  urlSession, parameters: ())
    }
}
