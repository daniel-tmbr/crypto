import SwiftUI

struct ApiSecurityView: View {
    private let apiSecurity: ApiSecurity
    
    init(_ security: ApiSecurity) { self.apiSecurity = security }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(apiSecurity.name)
                .font(.title2)
                .padding(.bottom, 4)
            ForEach(apiSecurity.keys, id: \.name) { key in
                SecurityKeyView(key: key)
                        .padding(.vertical, 4)
                Divider()
            }
            Link("How to setup \(apiSecurity.name) keys", destination: apiSecurity.help)
                .padding(.top, 4)
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
