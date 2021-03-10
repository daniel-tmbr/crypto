import Combine
import Foundation

public struct RequestPublisher<Parameter>: Publisher {
    public typealias Output = URLRequest
    public typealias Failure = RequestError
    typealias Assembler = (_ parameter: Parameter) throws -> URLRequest
    
    private let parameter: Parameter
    private let assembler: Assembler
    
    init(parameter: Parameter, assembler: @escaping Assembler) {
        self.parameter = parameter
        self.assembler = assembler
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        Deferred {
            Future { promise in
                do {
                    let request = try assembler(parameter)
                    promise(.success(request))
                } catch {
                    let requestError = RequestError(error: error, category: .compose)
                    promise(.failure(requestError))
                }
            }
        }
        .subscribe(subscriber)
    }
}
