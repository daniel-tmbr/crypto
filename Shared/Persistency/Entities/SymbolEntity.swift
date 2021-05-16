import Foundation
import CoreData

final class SymbolEntity: NSManagedObject {
    @NSManaged public var symbol: String
    @NSManaged public var baseAsset: String
    @NSManaged public var basePrecision: Int
    @NSManaged public var quoteAsset: String
    @NSManaged public var quotePrecision: Int
    @NSManaged public var status: String
    @NSManaged public var orderTypes: String
    @NSManaged public var isSpotTradingAllowed: Bool
    @NSManaged public var isOcoAllowed: Bool
    @NSManaged public var permissions: String
    @NSManaged public var updatedAt: Date
    
    @NSManaged public var klines: Set<KlineEntity>
    
    override func willSave() {
        super.willSave()
        updatedAt = Date()
    }
}

extension SymbolEntity: ManagedObject {
    static let entityName: String = "Symbol"
}

extension SymbolEntity: Identifiable {}

extension SymbolEntity {
    static let all = Fetch<SymbolEntity>.all
    static func find(_ symbol: String) -> Fetch<SymbolEntity> { .find(symbol: symbol) }
}

fileprivate extension NSPredicate {
    static func symbol(_ symbol: String) -> NSPredicate {
        NSPredicate(format: "%K == %s", #keyPath(SymbolEntity.symbol), symbol)
    }
}

extension Fetch where Entity == SymbolEntity {
    static let all = Fetch(
        sortDescriptors: { _ in [NSSortDescriptor(keyPath: \SymbolEntity.symbol, ascending: true)] }
    )
    
    static func find(symbol: String) -> Fetch {
        Fetch.one { _ in NSPredicate.symbol(symbol) }
    }
}

extension UpsertConfig where Entity == SymbolEntity {
    init(symbol: @escaping (Item) -> String, configure: @escaping (Item, Entity) -> Void) {
        self.init(
            predicate: { NSPredicate.symbol(symbol($0)) },
            configure: configure
        )
    }
}
