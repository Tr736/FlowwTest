
import Foundation
struct MarketChartRequest: APIRequest {
    typealias ResponseBody = MarketChartResponse

    var method: RequestMethod = .get
    var path: String = ""

    init(id: String) {
        path = Endpoints.marketChart(id: id)
    }
    
}
