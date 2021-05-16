import CoreData
import Foundation

public protocol ManagedObject: NSManagedObject {
    static var entityName: String { get }
}

public extension ManagedObject {
    static func newFetchRequest() -> NSFetchRequest<Self> {
        NSFetchRequest(entityName: entityName)
    }
}
