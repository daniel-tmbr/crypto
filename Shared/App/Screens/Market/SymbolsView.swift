import ComposableArchitecture
import SwiftUI

struct SymbolsView: View {
    private let store: Store<SymbolsState, SymbolsAction>
    @ObservedObject
    private var viewStore: ViewStore<SymbolsState, Never>
    
    init(store: Store<SymbolsState, SymbolsAction>) {
        self.store = store
        self.viewStore = ViewStore(store.actionless.scope(state: { $0 }))
    }
    
    var body: some View {
        List {
            ForEach(viewStore.symbols, id: \.coin) { symbol in
                Text(verbatim: symbol.coin)
            }
        }
    }
}

struct SymbolsView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolsView(store: Store(
            initialState: .empty,
            reducer: Reducer<SymbolsState, SymbolsAction, SymbolsEnvironment>.live,
            environment: SymbolsEnvironment.mock
        ))
    }
}
