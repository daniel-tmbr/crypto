import Foundation

public struct SymbolPair: Codable {
    public let value: String

    public init(_ value: String) {
        self.value = value
    }

    public init(baseAsset: Asset, quoteAsset: Asset) {
        value = baseAsset.value + quoteAsset.value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try container.decode(String.self)
    }
}
