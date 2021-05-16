import Combine
import CoreData
import Foundation

struct Operation<Result> {
    let exec: (NSManagedObjectContext) throws -> Result
}

struct ManagedOperation<Output>: Publisher {
    typealias Failure = Error
    
    private let context: NSManagedObjectContext
    private let operation: Operation<Output>
    
    init(context: NSManagedObjectContext,
         operation: Operation<Output>) {
        self.context = context
        self.operation = operation
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        Future { promise in
            context.perform {
                do {
                    let output = try operation.exec(context)
                    promise(.success(output))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .deferred()
        .receive(subscriber: subscriber)
    }
}

extension Publisher {
    func deferred() -> Deferred<Self> {
        Deferred(createPublisher: { self })
    }
}
