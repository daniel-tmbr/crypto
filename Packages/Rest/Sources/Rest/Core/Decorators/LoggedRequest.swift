import Foundation
import os.log

@dynamicMemberLookup
public struct LoggedRequest<R: Request>: Request {
    public typealias Input = R.Input
    public typealias Output = R.Output
    
    public typealias AssemblyLogging = (Logger, URLRequest, R.Input) -> Void
    public typealias AssemblyErrorLogging = (Logger, Error, R.Input) -> Void
    public typealias ParseLogging = (Logger, URLResponse, R.Output) -> Void
    public typealias ParseErrorLogging = (Logger, Error, URLResponse, Data) -> Void
    
    private let request: R
    private let logger: Logger
    
    private let assemblyLogging: AssemblyLogging?
    private let assemblyErrorLogging: AssemblyErrorLogging?
    private let parseLogging: ParseLogging?
    private let parseErrorLogging: ParseErrorLogging?
    
    init(
        request: R,
        logger: Logger = .request,
        assemblyLogging: AssemblyLogging? = nil,
        assemblyErrorLogging: AssemblyErrorLogging? = nil,
        parseLogging: ParseLogging? = nil,
        parseErrorLogging: ParseErrorLogging? = nil
    ) {
        self.request = request
        self.logger = logger
        self.assemblyLogging = assemblyLogging
        self.assemblyErrorLogging = assemblyErrorLogging
        self.parseLogging = parseLogging
        self.parseErrorLogging = parseErrorLogging
    }
    
    public func assemble(from data: Input) throws -> URLRequest {
        do {
            let urlRequest = try request.assemble(from: data)
            assemblyLogging?(logger, urlRequest, data)
            return urlRequest
        } catch {
            assemblyErrorLogging?(logger, error, data)
            throw error
        }
    }
    
    public func parse(data: Data, response: URLResponse) throws -> Output {
        do {
            let parsedResponse = try request.parse(data: data, response: response)
            parseLogging?(logger, response, parsedResponse)
            return parsedResponse
        } catch {
            parseErrorLogging?(logger, error, response, data)
            throw error
        }
    }

    subscript<T>(dynamicMember keyPath: KeyPath<R, T>) -> T {
        request[keyPath: keyPath]
    }
}

public extension Request {
    func logged(logger: Logger = .request,
                assemblyLogging: LoggedRequest<Self>.AssemblyLogging? = nil,
                assemblyErrorLogging: LoggedRequest<Self>.AssemblyErrorLogging? = nil,
                parseLogging: LoggedRequest<Self>.ParseLogging? = nil,
                parseErrorLogging: LoggedRequest<Self>.ParseErrorLogging? = nil) -> LoggedRequest<Self> {
        LoggedRequest(
            request: self,
            logger: logger,
            assemblyLogging: assemblyLogging,
            assemblyErrorLogging: assemblyErrorLogging,
            parseLogging: parseLogging,
            parseErrorLogging: parseErrorLogging
        )
    }
}
