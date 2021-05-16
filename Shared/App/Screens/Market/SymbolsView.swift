import Binance
import SwiftUI

struct SymbolsView: View {
    @ObservedObject
    private var symbols: Symbols
    
    @State
    private var selection: Symbol?
    
    init(symbols: Symbols = Symbols()) {
        self.symbols = symbols
    }
    
    var body: some View {
        List {
            ForEach(symbols.list) { symbol  in
                NavigationLink(
                    destination: Text(verbatim: symbol.symbol),
                    tag: symbol,
                    selection: $selection
                ) {
                    SymbolRowView(symbol: symbol)
                }
                .tag(symbol)
            }
        }
        .navigationTitle("\(symbols.list.count) symbols")
        .onAppear(perform: {
            guard symbols.list.isEmpty else { return }
            symbols.fetch()
        })
    }
}

struct CoinsView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolsView(symbols: .dummy)
    }
}
