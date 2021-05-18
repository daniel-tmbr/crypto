import CasePaths
import ComposableArchitecture
import Foundation

extension UserDefaults {
    func save<Value, Action>(for key: String) -> (Value?) -> Effect<Action, Never>
    where Value: RawRepresentable {
        return { value in
            Effect.fireAndForget { [weak self] in
                self?.setValue(value?.rawValue, forKey: key)
            }
        }
    }
    
    func read<Value, Action>(
        for key: String,
        path: CasePath<Action, Value>,
        default fallback: Value
    ) -> () -> Effect<Action, Never>
    where Value: RawRepresentable {
        return { [weak self] in
            guard let self = self,
                  let raw = self.value(forKey: key) as? Value.RawValue,
                  let value = Value(rawValue: raw) else {
                return Effect(value: path.embed(fallback))
            }
            return Effect(value: path.embed(value))
        }
    }
}
