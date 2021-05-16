import Foundation

public struct AnyRequest<Input, Output: Decodable>: Request {
    private let assembler: (Input) throws -> URLRequest
    private let parser: (Data, URLResponse) throws -> Output
        
    init<R: Request>(request: R)
    where R.Input == Input,
          R.Output == Output {
        assembler = request.assemble
        parser = request.parse
    }
    
    public func assemble(from data: Input) throws -> URLRequest {
        try assembler(data)
    }
    
    public func parse(data: Data, response: URLResponse) throws -> Output {
        try parser(data, response)
    }
}

public extension Request {
    func ereaseToAnyRequest() -> AnyRequest<Input, Output> {
        AnyRequest(request: self)
    }
}
