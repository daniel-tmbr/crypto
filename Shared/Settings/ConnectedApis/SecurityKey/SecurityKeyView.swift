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
                Text(key.error).foregroundColor(Color(.systemRed))
            }
        }
    }
    
    private var emptyView: some View {
        HStack {
            Image(systemName: key.error.isEmpty ? "seal" : "xmark.seal")
            TextField("Paste \(key.name)", text: $key.value, onCommit: { key.commit() })
                .textFieldStyle(PlainTextFieldStyle())
                .padding(5)
                .background(Color(.gray).opacity(0.1))
                .cornerRadius(4)
            Button {
                key.paste()
            } label: {
                Image(systemName: "doc.on.clipboard")
            }
            .buttonStyle(AccentButtonStyle())
        }
    }
    
    private var storedView: some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(Color(.systemGreen))
            Text("\(key.name) has been set")
                .truncationMode(.tail)
                .lineLimit(2)
            Spacer()
            Button(action: {
                key.value = ""
                key.commit()
            }, label: {
                Image(systemName: "trash")
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
