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
                    Text(L10n.Apis.subtitle.localizedKey)
                        .padding(.bottom)
                    ForEach(apis) { api in
                        ApiSecurityView(api)
                            .padding(.bottom)
                    }
                    HStack {
                        Image(systemName: "lock.shield.fill")
                            .foregroundColor(.blue)
                        Text(L10n.Apis.footnote.localizedKey)
                            .font(.footnote)
                    }
                    .foregroundColor(Color.secondaryLabel)
                }
                .padding()
            }
        }
        .navigationTitle(L10n.Apis.title.localizedKey)
    }
}

struct ConnectedApisView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectedApisView()
    }
}


