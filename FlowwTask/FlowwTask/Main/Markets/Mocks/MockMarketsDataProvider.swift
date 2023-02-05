import Foundation
final class MockMarketsDataProvider: MarketsDataProviderType {
    let api: APIType

    init(api: APIType = MockAPI()) {
        self.api = api
    }

    func getMarketsList() async throws -> [MarketResponse] {
        []
    }
}
