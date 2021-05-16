import CoreData
import Foundation

//struct UpdateConfig<Entity> {
//    let predicate: (Entity.Type) -> NSPredicate?
//    let configure: (Entity) -> Void
//}

struct UpsertConfig<Item, Entity> {
    let predicate: (Item) -> NSPredicate
    let configure: (Item, Entity) -> Void
}

//
//struct DeleteConfig<Entity> {
//    let predicate: (Entity.Type) -> NSPredicate?
//
//    static func all() -> DeleteConfig<Entity> {
//        DeleteConfig<Entity> { _ in nil }
//    }
//}
//
//extension UpdateConfig where Entity == CoinEntity {
//    static let delistAll = UpdateConfig(
//        predicate: { _ in nil },
//        configure: { $0.isDelisted = true }
//    )
//}

//extension UpsertConfig where Entity == CoinEntity, Item == Binance.Coin {
//    static let byAsset = UpsertConfig {
//        $0.coin.value
//    } configure: { (coin, entity) in
//        entity.coin = coin.coin.value
//        entity.name = coin.name
//        entity.trading = coin.trading
//        entity.isDelisted = false
//    }
//}
