import Foundation

public struct AnyRequest<Parameters, Response: Decodable>: Request {
    private let assembler: (Parameters) throws -> URLRequest
    private let parser: (Data, URLResponse) throws -> Response
        
    init<R: Request>(request: R)
    where R.RequestDataType == Parameters,
          R.ResponseDataType == Response {
        assembler = request.assemble
        parser = request.parse
    }
    
    public func assemble(from data: Parameters) throws -> URLRequest {
        try assembler(data)
    }
    
    public func parse(data: Data, response: URLResponse) throws -> Response {
        try parser(data, response)
    }
}

public extension Request {
    func ereaseToAnyRequest() -> AnyRequest<RequestDataType, ResponseDataType> {
        AnyRequest(request: self)
    }
}
