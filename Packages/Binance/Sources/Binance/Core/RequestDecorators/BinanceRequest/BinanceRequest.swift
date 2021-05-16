import Foundation
import Rest

protocol BinanceRequest: Request {
    func apiRequest() -> BinanceApiRequest<Self.Input, Self.Output>
}
