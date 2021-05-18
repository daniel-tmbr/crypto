import Binance
import ComposableArchitecture
import Foundation

struct SymbolsEnvironment {
    let localSymbols: Effect<SymbolsAction, Never>
    let remoteSymbols: Effect<SymbolsAction, Never>
    
    #if DEBUG
    static let mock = SymbolsEnvironment(
        localSymbols: .init(value: .fetched([Symbol(coin: "BTC")], .local)),
        remoteSymbols: .init(value: .fetched([Symbol(coin: "BTC"), Symbol(coin: "XLM")], .local))
    )
    #endif
}

extension AppEnvironment {
    var symbols: SymbolsEnvironment {
        SymbolsEnvironment(
            localSymbols: .init(value: .fetched([Symbol(coin: "BTC")], .local)),
            remoteSymbols: Market.exchangeInfo()
                .publisher()
                .map(\.symbols)
                .map { symbols in symbols.map { Symbol(coin: $0.baseAsset.value) } }
                .map { SymbolsAction.fetched($0, .remote) }
                .replaceError(with: .fetchError("Remote fetch error", .remote))
                .receive(on: mainQueue)
                .eraseToEffect()
        )
    }
}
