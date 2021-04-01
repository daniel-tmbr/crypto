import Foundation

public struct BinanceError: Decodable, Error {
    public let code: BinanceErrorCode
    public let msg: String
}
