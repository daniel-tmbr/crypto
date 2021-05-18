import Foundation
import ComposableArchitecture

enum FetchSource: Equatable {
    case local
    case remote
}

struct Symbol: Equatable {
    let coin: String
}

struct SymbolsState: Equatable {
    var symbols: [Symbol]
    fileprivate var fetchingFrom: Set<FetchSource>
    var isFetching: Bool { !fetchingFrom.isEmpty }
    
    static let empty = SymbolsState(symbols: [], fetchingFrom: [])
}

enum SymbolsAction: Equatable {
    case fetch
    case fetching(FetchSource)
    case fetched([Symbol], FetchSource)
    case fetchError(String, FetchSource)
}

extension Reducer
where State == SymbolsState,
      Action == SymbolsAction,
      Environment == SymbolsEnvironment {
    static let live =  Reducer { state, action, env in
        switch action {
        case .fetch:
            return Effect.concatenate(
                env.localSymbols,
                env.remoteSymbols
            )
        case .fetching(let source):
            state.fetchingFrom.insert(source)
            return .none
        case .fetched(let symbols, let source):
            state.fetchingFrom.remove(source)
            state.symbols = symbols
            return .none
        case .fetchError(let error, let source):
            state.fetchingFrom.remove(source)
            return .none
        }
    }
}
