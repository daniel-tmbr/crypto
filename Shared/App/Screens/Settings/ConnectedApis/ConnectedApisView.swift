import SwiftUI
import Rest

struct ConnectedApisView: View {
    private let apis: [ApiSecurity]
    
    public init(apis: [ApiSecurity] = ApiSecurity.all) {
        self.apis = apis
    }
    
    private let subtitleText = Text(L10n.Apis.subtitle.localizedKey)
    private let footnoteText = Text(L10n.Apis.footnote.localizedKey)
    
    var body: some View {
        ZStack {
            Color.secondaryBackground
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(alignment: .leading) {
                    subtitleText
                        .accessibilityElement(children: .ignore)
                        .accessibilityHint(subtitleText)
                        .padding(.bottom)
                    ForEach(apis) { api in
                        ApiSecurityView(api)
                            .padding(.bottom)
                    }
                    HStack {
                        Image(systemName: "lock.shield.fill")
                            .foregroundColor(.blue)
                        footnoteText
                            .font(.footnote)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(hint: footnoteText)
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


