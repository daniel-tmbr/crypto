import Foundation

protocol Signer {
    func sign(value: String, with key: String) throws -> String
}
