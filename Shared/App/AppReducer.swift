import Binance
import CasePaths
import ComposableArchitecture
import Foundation

extension Reducer
where State == AppState,
      Action == AppAction,
      Environment == AppEnvironment {
    static let app = Reducer.combine(
        Reducer<SymbolsState, SymbolsAction, SymbolsEnvironment>.live.pullback(
            state: \.symbols,
            action: /AppAction.symbols,
            environment: { $0.symbols }
        ),
        Reducer<Screen, ScreenAction, ScreenEnvironment>.live.pullback(
            state: \.screen,
            action: /AppAction.screen,
            environment: { $0.screen }
        ),
        Reducer { state, action, _ in
            switch action {
            case .launched:
                return Effect(value: .symbols(.fetch))
            case .symbols,
                 .screen:
                return .none
            }
        }
    )
}
