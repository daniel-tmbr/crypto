import Combine
import Binance
import Foundation

extension Symbol {
    static let btc = Symbol(
        baseAsset: "BTC",
        baseAssetPrecision: 8,
        quoteAsset: "EUR",
        quotePrecision: 2,
        orderTypes: OrderType.allCases,
        isSpotTradingAllowed: true,
        updated: Date()
    )
}

final class Symbols: ObservableObject {
    @Published
    var list: [Symbol] = []
    private var subscriptions = Set<AnyCancellable>()
    
    func fetch() {
//        let availableAssets = Wallet.coins()
//            .publisher(input: CoinParams())
//            .catch { error -> Just<[Coin]> in
//                print(error.localizedDescription)
//                return Just([])
//            }
//            .mapElements(\.coin)
//            .map(Set.init)
//            .share()
//        
//        let btcSymbols = Market.exchangeInfo()
//            .publisher()
//            .map(\.symbols)
//            .filterElements { $0.quoteAsset == .btc && $0.isSpotTradingAllowed }
//            .catch { error -> Just<[Symbol]> in
//                print(error.localizedDescription)
//                return Just([])
//            }
//            .map { symbols -> [Symbol] in
//                print("Number of symbols: \(symbols.count)")
//                return symbols
//            }
//        
//        availableAssets.combineLatest(btcSymbols) { (assets, symbols) -> [Asset] in
//            symbols.compactMap {
//                assets.contains($0.baseAsset) ? $0.baseAsset : nil
//            }.sorted { $0.value < $1.value }
//        }
//        .receive(on: DispatchQueue.main)
//        .assign(to: \.list, on: self)
//        .store(in: &subscriptions)
    }
    
    static let dummy = Symbols()
}
