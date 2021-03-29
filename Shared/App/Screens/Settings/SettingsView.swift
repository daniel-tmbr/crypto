import SwiftUI

struct SettingsView: View {
    private enum Page: Int, Identifiable {
        case apis
        var id: Int { rawValue }
    }
    
    @State private var selection: Page?
    
    var body: some View {
        List {
            NavigationLink(
                destination: ConnectedApisView(),
                tag: Page.apis,
                selection: $selection
            ) {
                Label(L10n.Apis.title.localizedKey, systemImage: "network")
                    .accessibility(label: Text(L10n.Apis.title.localizedKey))
            }
            .tag(Page.apis)
        }
        .navigationTitle(L10n.Settings.title.localizedKey)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
