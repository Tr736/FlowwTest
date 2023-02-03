import Foundation

enum Endpoints {
    static let baseURL = "https://api.coingecko.com/api/"

    static func markets(page:Int, perPage: Int) -> String {
        "v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=\(perPage)&page=\(page)&sparkline=false"
    }

    static func marketChart(id: String) -> String {
        "v3/coins/\(id)/market_chart?vs_currency=usd&days=365&interval=daily"
    }
}
