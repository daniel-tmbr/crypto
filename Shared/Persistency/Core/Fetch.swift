import CoreData
import Foundation

struct Fetch<Entity: NSManagedObject> {
    let config: (NSFetchRequest<Entity>) -> NSFetchRequest<Entity>
}

extension Fetch {
    init(
        limit: Int = 0,
        batchSize: Int = 50,
        predicate: @escaping (Entity.Type) -> NSPredicate? = { _ in nil },
        sortDescriptors: @escaping (Entity.Type) -> [NSSortDescriptor] = { _ in [] }
    ) {
        config = { request in
            request.fetchLimit = limit
            request.fetchBatchSize = batchSize
            request.predicate = predicate(Entity.self)
            request.sortDescriptors = sortDescriptors(Entity.self)
            return request
        }
    }
    
    static func one(predicate: @escaping (Entity.Type) -> NSPredicate?,
                    sortDescriptors: @escaping (Entity.Type) -> [NSSortDescriptor] = { _ in [] }) -> Fetch<Entity> {
        self.init(limit: 1, batchSize: 1, predicate: predicate, sortDescriptors: sortDescriptors)
    }
}
