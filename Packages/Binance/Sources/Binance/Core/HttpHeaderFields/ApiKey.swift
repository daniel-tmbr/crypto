import Foundation
import Rest

struct ApiKey: HttpHeaderField {
    public let key: String = "X-MBX-APIKEY"
    public var value: String
}
