import Foundation
import CoreData

final class KlineEntity: NSManagedObject {
    @NSManaged public var openTime: Date
    @NSManaged public var closeTime: Date
    @NSManaged public var open: NSNumber
    @NSManaged public var close: NSNumber
    @NSManaged public var high: NSNumber
    @NSManaged public var low: NSNumber
    @NSManaged public var volume: NSNumber
    @NSManaged public var quoteAssetVolume: NSNumber
    @NSManaged public var numberOfTrades: Int
    @NSManaged public var updatedAt: Date

    @NSManaged public var symbol: SymbolEntity
    
    override func willSave() {
        super.willSave()
        updatedAt = Date()
    }
}

extension KlineEntity: ManagedObject {
    static let entityName: String = "Kline"
}

extension KlineEntity: Identifiable {}
