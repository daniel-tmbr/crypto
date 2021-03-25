import SwiftUI
import Rest

struct ConnectedApisView: View {
    private let apis: [ApiSecurity]
    
    public init(apis: [ApiSecurity] = ApiSecurity.all) {
        self.apis = apis
    }
    
    var body: some View {
        ZStack {
            Color.secondaryBackground
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Text("To use the app, you have to provide your own Secret Keys for the following APIs.")
                        .padding(.bottom)
                    ForEach(apis) { api in
                        ApiSecurityView(api)
                            .padding(.bottom)
                    }
                    HStack {
                        Image(systemName: "lock.shield.fill")
                            .foregroundColor(.blue)
                        Text("Secret Keys are stored securely in Apple's Keychain and only displayed while you're typing them in. You can delete and replace them any time.")
                            .font(.footnote)
                    }
                    .foregroundColor(Color.secondaryLabel)
                }
                .padding()
            }
            .navigationTitle("Connected APIs")
        }
    }
}

struct ConnectedApisView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectedApisView()
    }
}


