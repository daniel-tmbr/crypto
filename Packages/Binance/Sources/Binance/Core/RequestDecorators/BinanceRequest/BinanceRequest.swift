import Foundation
import Rest

protocol BinanceRequest: Request {
    func apiRequest() -> BinanceApiRequest<RequestDataType, ResponseDataType>
}
