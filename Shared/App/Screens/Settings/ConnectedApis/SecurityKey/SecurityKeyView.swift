import Rest
import SwiftUI

struct SecurityKeyView: View {
    @ObservedObject
    var key: SecurityKey
    
    var body: some View {
        VStack {
            if !key.value.isEmpty {
                storedView
            } else {
                emptyView
            }
            if !key.error.isEmpty {
                Text(key.error.localizedKey)
                    .foregroundColor(Color(.systemRed))
            }
        }
    }
    
    private var emptyView: some View {
        HStack {
            Image(systemName: key.error.isEmpty ? "seal" : "xmark.seal")
                .accessibilityHidden(true)
            TextField(L10n.SecurityKey.placeholder(key.name), text: $key.value, onCommit: { key.commit() })
                .textFieldStyle(PlainTextFieldStyle())
                .padding(5)
                .background(Color(.gray).opacity(0.1))
                .cornerRadius(4)
                .accessibilityAction(named: L10n.SecurityKey.paste.localizedKey) {
                    key.paste()
                }
            Button {
                key.paste()
            } label: {
                Image(systemName: "doc.on.clipboard")
            }
            .buttonStyle(AccentButtonStyle())
            .accessibilityHidden(true)
        }
    }
    
    private var storedView: some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(Color(.systemGreen))
                .accessibilityHidden(true)
            Text(L10n.SecurityKey.stored(key.name))
                .truncationMode(.tail)
                .lineLimit(2)
            Spacer()
            Button(action: {
                key.value = ""
                key.commit()
            }, label: {
                Image(systemName: "trash")
                    .accessibilityLabel(L10n.SecurityKey.delete.localizedKey)
            })
            .buttonStyle(AccentButtonStyle())
        }
    }
}

struct SecurityKeyView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityKeyView(
            key: SecurityKey(name: "Api key", key: Key())
        )
        .previewLayout(PreviewLayout.sizeThatFits)
    }
    
    final class Key: ApiSecurityKey {
        func read() throws -> String? { "Key" }
        func store(string: String?) throws {}
    }
}
