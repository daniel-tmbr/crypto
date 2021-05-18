import Foundation

struct AppState: Equatable {
    var screen: Screen
    var symbols: SymbolsState
    
    init(
        screen: Screen = .home,
        symbols: SymbolsState = .empty
    ) {
        self.screen = screen
        self.symbols = symbols
    }
}

enum AppAction: Equatable {
    case launched
    case screen(ScreenAction)
    case symbols(SymbolsAction)
}
