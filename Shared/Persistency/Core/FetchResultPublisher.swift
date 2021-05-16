import Combine
import CoreData
import Foundation

public struct FetchedResults<Entity: ManagedObject>: Publisher {
    public enum FetchError: Error {
        case fetch(Error)
        case missingObjects
    }
    
    public typealias Output = [Entity]
    public typealias Failure = FetchError

    private let request: NSFetchRequest<Entity>
    private let context: NSManagedObjectContext
    private let controller: NSFetchedResultsController<Entity>
    private let controllerDelegate: Delegate
    private let entitites: CurrentValueSubject<[Entity], FetchError>

    public init(context: NSManagedObjectContext, request: NSFetchRequest<Entity>) {
        self.context = context
        self.request = request
        let entitites = CurrentValueSubject<[Entity], FetchError>([])
        let controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controllerDelegate = Delegate {
            if let objects = controller.fetchedObjects {
                entitites.send(objects)
            } else {
                entitites.send(completion: .failure(.missingObjects))
            }
        }
        controller.delegate = controllerDelegate
        self.controller = controller
        self.entitites = entitites
    }
    
    init(context: NSManagedObjectContext, fetch: Fetch<Entity>) {
        self.init(context: context, request: fetch.config(Entity.newFetchRequest()))
    }

    public func receive<S>(subscriber: S)
    where S: Subscriber,
          Failure == S.Failure,
          Output == S.Input {
        if controller.fetchedObjects == nil { performFetch() }
        entitites.receive(subscriber: subscriber)
    }
    
    private func performFetch() {
        do {
            try controller.performFetch()
        } catch {
            let e = FetchError.fetch(error)
            entitites.send(completion: .failure(e))
        }
    }
}

fileprivate final class Delegate: NSObject, NSFetchedResultsControllerDelegate {
    private let contentDidChange: () -> Void
    
    init(contentDidChange: @escaping () -> Void) {
        self.contentDidChange = contentDidChange
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        contentDidChange()
    }
}
