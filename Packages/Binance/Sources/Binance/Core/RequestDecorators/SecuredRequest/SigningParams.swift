import Foundation

struct Signature: Encodable {
    let signature: String
}

struct SigningParams: Encodable {
    /// Miliseconds since 1st of January, 1970
    let timestamp: Int
    /// Miliseconds, in the inclusive range of [5000 ... 60000]
    let recvWindow: Int?
}
