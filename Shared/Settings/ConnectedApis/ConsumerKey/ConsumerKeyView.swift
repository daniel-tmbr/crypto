import Rest
import SwiftUI

struct ConsumerKeyView: View {
    @ObservedObject
    var key: ConsumerKey
    
    var body: some View {
        switch key.state {
        case .none: emptyView()
        case .stored: storedView()
        case .error(let error): errorView(error: error)
        }
        Divider()
    }
    
    private func emptyView() -> some View {
        HStack {
            Image(systemName: "seal")
            TextField("Type in your \(key.name)", text: $key.value, onCommit:  {
                key.commit()
            })
            .textFieldStyle(PlainTextFieldStyle())
            .padding(5)
            .background(Color(.gray).opacity(0.1))
            .cornerRadius(4)
        }
    }
    
    private func storedView() -> some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(Color(.systemGreen))
            Text("\(key.name) has been set")
                .truncationMode(.tail)
                .lineLimit(2)
            Spacer()
            deleteButton()
        }
    }
    
    private func errorView(error: Error) -> some View {
        VStack {
            HStack {
                Image(systemName: "xmark.seal")
                    .foregroundColor(Color(.systemRed))
                TextField("Type in your \(key.name)", text: $key.value, onCommit: { key.commit() })
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(5)
                    .background(Color(.gray).opacity(0.1))
                    .cornerRadius(4)
                deleteButton()
            }
            Text("\(error.localizedDescription)")
                .foregroundColor(Color(.systemRed))
        }
    }
    
    private func deleteButton() -> some View {
        Button(action: {
            key.value = ""
            key.commit()
        }, label: {
            Image(systemName: "trash")
        })
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct ConsumerKeyView_Previews: PreviewProvider {
    static var previews: some View {
        ConsumerKeyView(
            key: ConsumerKey(store: Store())
        )
        .previewLayout(PreviewLayout.sizeThatFits)
    }
    
    final class Store: ConsumerKeyStore {
        let type: ConsumerKeyType = .apiKey
        func read() throws -> String? { "Key" }
        func store(string: String?) throws {}
    }
}
