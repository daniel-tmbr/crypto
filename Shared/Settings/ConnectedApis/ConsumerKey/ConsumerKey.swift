import Combine
import Foundation
import Rest

final class ConsumerKey: ObservableObject {
    enum State {
        case none
        case stored
        case error(Error)
    }
    
    @Published
    private(set) var state: State = .none
    @Published
    var value: String = ""
    
    private let store: ConsumerKeyStore
    var name: String { store.type.name }
    
    init(store: ConsumerKeyStore) {
        self.store = store
        read()
    }
    
    func commit() {
        store(key: value)
    }
    
    private func read() {
        do {
            value = mask(key: try store.read() ?? "")
            state = value.isEmpty ? .none : .stored
        } catch {
            state = .error(error)
        }
    }
    
    private func store(key: String) {
        do {
            try store.store(string: key)
            value = mask(key: key)
            state = .stored
        } catch {
            state = .error(error)
        }
    }
    
    private func delete() {
        do {
            try store.store(string: nil)
            state = .none
        } catch {
            state = .error(error)
        }
    }
    
    private func mask(key: String) -> String {
        String(key.map { _ in "•" })
    }
}
