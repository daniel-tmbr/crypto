import SwiftUI

struct ApiSecurityView: View {
    private let apiSecurity: ApiSecurity
    #if os(macOS)
    @Environment(\.openURL) var openURL
    #endif
    
    init(_ security: ApiSecurity) { self.apiSecurity = security }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(apiSecurity.name)
                .font(.title2)
                .padding(.bottom, 4)
                .accessibilityAddTraits(.isHeader)
            ForEach(apiSecurity.keys, id: \.name) { key in
                SecurityKeyView(key: key)
                        .padding(.vertical, 4)
                Divider()
            }
            #if os(iOS)
            Link(L10n.Apis.setup(apiSecurity.name), destination: apiSecurity.help)
                .padding(.top, 4)
            #else
            // TECHDEBT: Link was freezing the macOS app
            Button(L10n.Apis.setup(apiSecurity.name)) {
                openURL(apiSecurity.help)
            }
            .padding(.top, 4)
            .buttonStyle(AccentButtonStyle())
            #endif
        }
        .padding()
        .background(Color.background)
        .cornerRadius(10)
    }
}

struct ApiSecurityConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ApiSecurityView(ApiSecurity.all[0])
    }
}
