import Foundation

enum SigningError: Error {
    case missingUrl
    case malformedUrl(URL)
    case malformedBody(Data)
    
    case apiKeyMissing
    case apiSecretMissing
    
    case queryIsEmpty(URLComponents)
    case signingDataEncode(String, String.Encoding)
    case signingKeyEncode(String.Encoding)
    
    case invalidComponents(URLComponents)
}
