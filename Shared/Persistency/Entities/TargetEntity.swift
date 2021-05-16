import Foundation
import CoreData

final class TargetEntity: NSManagedObject {
    @NSManaged public var baseCoin: String
    @NSManaged public var quoteCoin: String
    @NSManaged public var target: NSNumber?
    @NSManaged public var type: String?
    @NSManaged public var updatedAt: Date?
    
    override func willSave() {
        super.willSave()
        updatedAt = Date()
    }
}

extension TargetEntity: ManagedObject {
    static let entityName: String = "Target"
}

extension TargetEntity : Identifiable {}
