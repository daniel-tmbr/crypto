import Foundation
import CoreData

final class AssetEntity: NSManagedObject {
    @NSManaged public var coin: String
    @NSManaged public var name: String
    @NSManaged public var isTrading: Bool
    @NSManaged public var isDelisted: Bool
    @NSManaged public var updatedAt: Date
    
    override func willSave() {
        super.willSave()
        updatedAt = Date()
    }
}

extension AssetEntity: ManagedObject {
    static let entityName: String = "Asset"
}

extension AssetEntity: Identifiable {}

extension AssetEntity {
    static let all = Fetch<AssetEntity>.all
    static func find(coin: String) -> Fetch<AssetEntity> { .find(coin: coin) }
}

fileprivate extension NSPredicate {
    static func asset(by coin: String) -> NSPredicate {
        NSPredicate(format: "%K == %s", #keyPath(AssetEntity.coin), coin)
    }
}

fileprivate extension Fetch where Entity == AssetEntity {
    static let all = Fetch(
        sortDescriptors: { _ in [NSSortDescriptor(keyPath: \AssetEntity.name, ascending: true)] }
    )
    
    static func find(coin: String) -> Fetch {
        Fetch.one { _ in NSPredicate.asset(by: coin) }
    }
}

extension UpsertConfig where Entity == AssetEntity {
    init(coin: @escaping (Item) -> String, configure: @escaping (Item, Entity) -> Void) {
        self.init(
            predicate: { NSPredicate.asset(by: coin($0)) },
            configure: configure
        )
    }
}
