import Foundation

struct MarketRequest: APIRequest {
    typealias ResponseBody = [MarketResponse]

    var method: RequestMethod = .get
    var path: String = ""

    init(page: Int, perPage: Int) {
        self.path = Endpoints.markets(page: page, perPage: perPage)
    }
}


struct MarketResponse: Decodable, Hashable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let currentPrice: Double
    let marketCapRank: Int
    let marketCap: Double
    let totalVolume: Double
    let priceChangePercentage24h: Double

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(URL.self, forKey: .image)
        self.currentPrice = try container.decode(Double.self, forKey: .currentPrice)
        self.marketCapRank = try container.decode(Int.self, forKey: .marketCapRank)
        self.marketCap = try container.decode(Double.self, forKey: .marketCap)
        self.totalVolume = try container.decode(Double.self, forKey: .totalVolume)
        self.priceChangePercentage24h = try container.decode(Double.self, forKey: .priceChangePercentage24h)
    }

    #if DEBUG
    init(id: String = "Bitcoin",
         symbol: String = "btc",
         name: String = "Bitcoin",
         image: URL = URL(string: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579")!,
         currentPrice: Double = 23816,
         marketCap: Double = 458828872094,
         marketCapRank: Int = 1,
         totalVolume: Double = 42208866232,
         priceChangePercentage24h: Double = 3.40442) {
        
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCapRank = marketCapRank
        self.marketCap = marketCap
        self.totalVolume = totalVolume
        self.priceChangePercentage24h = priceChangePercentage24h
    }
    #endif
}

