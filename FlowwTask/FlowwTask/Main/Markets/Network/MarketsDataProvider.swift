
import Foundation
protocol MarketsDataProviderType: ObservableObject {
    var api: APIType { get }

    func getMarketsList() async throws -> [MarketResponse]
}

final class MarketsDataProvider: MarketsDataProviderType {
    let api: APIType

    init(api: APIType = ConcreteAPI()) {
        self.api = api
    }

    func getMarketsList() async throws -> [MarketResponse] {
        let request = MarketRequest(page: 1, perPage: 100)
        return try await api.execute(apiRequest: request)
    }
}
