import Combine
import Foundation

public protocol Request {
    associatedtype RequestDataType
    associatedtype ResponseDataType: Decodable
    func assemble(from data: RequestDataType) throws -> URLRequest
    func parse(data: Data, response: URLResponse) throws -> ResponseDataType
}

extension Request {
    func requestPublisher(from data: RequestDataType) -> RequestPublisher<RequestDataType> {
        RequestPublisher(parameter: data, assembler: assemble)
    }
    
    public func publisher(parameters: RequestDataType, urlSession: URLSession = .shared) -> ResponsePublisher<ResponseDataType> {
        requestPublisher(from: parameters)
            .flatMap {
                urlSession
                    .dataTaskPublisher(for: $0)
                    .mapError(RequestError.init(urlError:))
            }
            .responsePublisher(parser: parse)
    }
}

extension Request where RequestDataType == Void {
    public func publisher(urlSession: URLSession = .shared) -> ResponsePublisher<ResponseDataType> {
        publisher(parameters: (), urlSession:  urlSession)
    }
}
