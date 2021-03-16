import SwiftUI

struct SettingsView: View {
    private var configs: [ApiSecurityConfigViewModel] = [
        ApiSecurityConfigViewModel(config: .binance),
        ApiSecurityConfigViewModel(config: .twitter),
    ]
    
    public init() {}
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Connected APIs")
                .font(.title)
                .padding(.horizontal)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Text("To use the app, you have to provide your own Consumer Keys for the following services.")
                        .padding(.bottom)
                    ForEach(configs, id: \.name) { config in
                        ApiSecurityConfigView(config: config)
                            .padding(.bottom)
                    }
                    HStack {
                        Image(systemName: "lock.shield.fill")
                            .foregroundColor(.blue)
                        Text("Consumer Keys are stored in Apple's Keychain and they are only displayed at the time you add them. You can delete and replace them any time.")
                            .font(.footnote)
                    }
                    .foregroundColor(Color.secondaryLabel)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
