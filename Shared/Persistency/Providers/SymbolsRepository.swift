import Foundation
import Binance
import CoreData
import Combine

struct Asset {
    let coin: String
    let name: String
    let isTrading: Bool
    let updated: Date
}

public enum OrderType: CaseIterable {
    case limit
    case market
    case stopLoss
    case stopLossLimit
    case takeProfit
    case takeProfitLimit
    case limitMaker
}

struct Symbol: Hashable, Identifiable {
    var id: String { symbol }
    var symbol: String { "\(baseAsset)\(quoteAsset)" }
    let baseAsset: String
    let baseAssetPrecision: Int
    let quoteAsset: String
    let quotePrecision: Int
    let orderTypes: [OrderType]
    let isSpotTradingAllowed: Bool
    let updated: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(symbol)
    }
}

final class SymbolsRepository: ObservableObject {
    private let symbols: BinanceEndpoint<Void, ExchangeInfo>
    private let storage: Storage
    
    init(storage: Storage) {
        self.symbols = Market.exchangeInfo()
        self.storage = storage
    }
    
    func symbols(tolerance: TimeInterval) -> AnyPublisher<[Symbol], Error> {
        let now = Date()
        
        let storedSymbols = storage
            .fetch(SymbolEntity.all)
            .mapElements(mapSymbol)
            .share()
        
        let updatePublisher = storedSymbols
            .maxElement(by: \.updated)
            .map { symbol -> Bool in
                guard let updated = symbol?.updated else { return true }
                return now.timeIntervalSince(updated) > tolerance
            }
        
        return storedSymbols
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    private func mapSymbol(_ entity: SymbolEntity) -> Symbol {
        Symbol(
            baseAsset: entity.baseAsset,
            baseAssetPrecision: Int(entity.basePrecision),
            quoteAsset: entity.quoteAsset,
            quotePrecision: Int(entity.quotePrecision),
            orderTypes: [],
            isSpotTradingAllowed: entity.isSpotTradingAllowed,
            updated: entity.updatedAt
        )
    }
    
    private func mapAsset(_ entity: AssetEntity) -> Asset {
        Asset(
            coin: entity.coin,
            name: entity.name,
            isTrading: entity.isTrading,
            updated: entity.updatedAt
        )
    }
    
    private func save(_ response: ([Binance.Coin], Binance.ExchangeInfo)) {
        let (coins, info) = response
        storage.perform(
            operation: .upsert(coins: coins, symbols: info.symbols, updatedAt: Date())
        )
    }
}

extension Operation {
    static func upsert(coins: [Coin],
                       symbols: [Binance.Symbol],
                       updatedAt: Date) -> Operation<[SymbolEntity]> {
        let upsertCoins = UpsertConfig<Coin, AssetEntity>(
            coin: { $0.coin.value },
            configure: { coin, entity in
                entity.coin = coin.coin.value
                entity.name = coin.name
                entity.isTrading = coin.trading
                entity.updatedAt = updatedAt
            }
        )
        let upsertSymbols = UpsertConfig<Binance.Symbol, SymbolEntity>(
            symbol: { $0.symbol.value },
            configure: { symbol, entity in
                entity.symbol = symbol.symbol.value
//                entity.status = symbol.status
//                entity.baseAsset = symbol.baseAsset
                entity.basePrecision = symbol.basePrecision
//                entity.quoteAsset = symbol.quoteAsset
                entity.quotePrecision = symbol.quotePrecision
//                entity.orderTypes = symbol.orderTypes
                entity.isOcoAllowed = symbol.ocoAllowed
                entity.isSpotTradingAllowed = symbol.isSpotTradingAllowed
//                entity.filters = symbol.filters
                entity.updatedAt = updatedAt
            }
        )
        return Operation<[SymbolEntity]> { ctx in
            let assetEntities = Set(try coins.map {
                try ctx.upsert(item: $0, config: upsertCoins)
            })
            let assets = Set(assetEntities.map { $0.coin })
            let symbolEntities = try symbols
                .filter { assets.contains($0.baseAsset.value) && assets.contains($0.quoteAsset.value) }
                .map { try ctx.upsert(item: $0, config: upsertSymbols) }
            
            
            
            try ctx.saveChanges()
            return symbolEntities
        }
    }
}
