import SwiftUI

struct ApiSecurityConfigView: View {
    let config: ApiSecurityConfigViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(config.name)
                .font(.title3)
                .padding(.bottom, 4)
            ConsumerKeyView(key: config.apiKey)
                .padding(.vertical, 4)
            ConsumerKeyView(key: config.secretKey)
                .padding(.vertical, 4)
        }
    }
}

struct ApiSecurityConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ApiSecurityConfigView(config: .init(config: .binance))
    }
}
