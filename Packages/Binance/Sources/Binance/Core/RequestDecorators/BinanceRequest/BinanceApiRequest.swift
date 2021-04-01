import Foundation
import Rest

protocol BinanceApiRequest {
    associatedtype RequestData
    associatedtype ResponseData: Decodable
    
    func binanceApiRequest() -> BinanceRequest<RequestData, ResponseData>
}
