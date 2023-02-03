
import Foundation
protocol MarketDetailsViewDataProviderType: ObservableObject {
    var marketItem: MarketResponse { get }
    var chartDataPublisher: Published<[MarketChartData]>.Publisher { get }

    func getChartData() async throws
}

final class MockMarketDetailsViewDataProvider: MarketDetailsViewDataProviderType {

    private let api: APIType
    let marketItem: MarketResponse
    @Published var chartData: [MarketChartData] = []
    var chartDataPublisher: Published<[MarketChartData]>.Publisher {
        $chartData
    }

    init(api: APIType = MockAPI(),
         marketItem: MarketResponse) {
        self.marketItem = marketItem
        self.api = api
    }

    func getChartData() async throws {
        let request = MarketChartRequest(id: marketItem.id)

        let response = try await api.execute(apiRequest: request)
        convertToDateAndPrice(response)
    }

    func convertToDateAndPrice(_ response: MarketChartResponse) {
        var marketChartData = [MarketChartData]()
        for (idx, element) in response.prices.enumerated() {
            let date = Calendar.current.date(byAdding: .day, value: -idx, to: Date())
            let price = element.last
            marketChartData.append(MarketChartData(date: date, price: price))
        }
        self.chartData = marketChartData
    }

}
final class MarketDetailsViewDataProvider: MarketDetailsViewDataProviderType {
    private let api: APIType
    let marketItem: MarketResponse
    @Published var chartData: [MarketChartData] = []
    var chartDataPublisher: Published<[MarketChartData]>.Publisher {
        $chartData
    }

    init(api: APIType = ConcreteAPI(),
         marketItem: MarketResponse) {
        self.marketItem = marketItem
        self.api = api
    }

    func getChartData() async throws {
        let request = MarketChartRequest(id: marketItem.id)

        let response = try await api.execute(apiRequest: request)
        await convertToDateAndPrice(response)
    }

    @MainActor
    func convertToDateAndPrice(_ response: MarketChartResponse) {
        var marketChartData = [MarketChartData]()
        for (idx, element) in response.prices.enumerated() {
            let date = Calendar.current.date(byAdding: .day, value: -365 + idx, to: Date())
            let price = element.last
            marketChartData.append(MarketChartData(date: date, price: price))
        }
        self.chartData = marketChartData
    }
}
