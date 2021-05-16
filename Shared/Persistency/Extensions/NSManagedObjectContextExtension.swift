import CoreData
import Combine
import Foundation

extension NSManagedObjectContext {
    func saveChanges() throws {
        try hasChanges ? save() : reset()
    }
    
    func upsert<Item, Entity: ManagedObject>(item: Item, config: UpsertConfig<Item, Entity>) throws -> Entity {
        let entity: Entity = try insertOrFind(matching: config.predicate(item))
        config.configure(item, entity)
        return entity
    }
    
    public func insertOrFind<Entity: ManagedObject>(matching predicate: NSPredicate) throws -> Entity {
        if let entity: Entity = materializedObject(matching: predicate) {
            return entity
        } else if let entity: Entity = try? fetch(matching: predicate).first {
            return entity
        } else {
            return Entity(context: self)
        }
    }
    
    private func materializedObject<Entity: ManagedObject>(matching predicate: NSPredicate) -> Entity? {
        registeredObjects.first { !$0.isFault && $0 is Entity && predicate.evaluate(with: $0) } as? Entity
    }
    
    private func fetch<Entity: ManagedObject>(matching predicate: NSPredicate) throws -> [Entity] {
        let request = Entity.newFetchRequest()
        request.predicate = predicate
        return try fetch(request)
    }
    
    func perform<Output>(_ operation: Operation<Output>) -> ManagedOperation<Output> {
        ManagedOperation(context: self, operation: operation)
    }
}
