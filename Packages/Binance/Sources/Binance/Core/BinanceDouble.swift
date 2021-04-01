import Foundation

public struct BinanceDouble: Decodable, CustomStringConvertible {
    public let value: Double
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        guard let value = Double(string) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Couldn't convert String (\(string)) to Double"
            )
        }
        self.value = value
    }
    
    public init(value: Double) {
        self.value = value
    }
    
    private enum BinanceDoubleCodingKey: CodingKey {
        case error
    }
    
    public var description: String {
        "\(value)"
    }
}
