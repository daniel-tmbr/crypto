import Binance
import SwiftUI

struct SymbolRowView: View {
    let symbol: Symbol
    var body: some View {
        Text(verbatim: symbol.baseAsset)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolRowView(symbol: .btc)
            .previewLayout(.sizeThatFits)
    }
}
