import CryptoKit
import Foundation

struct HmacSigner: Signer {
    private let encoding: String.Encoding
    
    init(encoding: String.Encoding = .utf8) {
        self.encoding = encoding
    }
    
    func sign(value: String, with key: String) throws -> String {
        guard let signingData = value.data(using: encoding)
            else { throw SigningError.signingDataEncode(value, encoding) }
        guard let signingKey = key.data(using: encoding)
            else { throw SigningError.signingKeyEncode(encoding) }
        let signedData = HMAC<SHA256>.authenticationCode(
            for: signingData,
            using: SymmetricKey(data: signingKey)
        )
        return signedData
            .map { String(format: "%02hhx", $0) }
            .joined()
    }
}
