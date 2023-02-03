import Foundation
protocol MarketDetailsViewModelType: ObservableObject {
    var chartDataPublisher: Published<[MarketChartData]>.Publisher { get }
    var imageURL: URL { get }

    var symbol: String { get }

    var todaysDate: String { get }

    var totalValue: String {get }
    func getChartData()
}

final class MockMarketDetailsViewModel: MarketDetailsViewModelType {
    var chartDataPublisher: Published<[MarketChartData]>.Publisher {
        dataProvider.chartDataPublisher
    }

    var imageURL: URL {
        dataProvider.marketItem.image
    }

    var symbol: String {
        dataProvider.marketItem.symbol.uppercased()
    }

    var todaysDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        return dateFormatter.string(from: Date())
    }

    var totalValue: String {
        "$" + dataProvider.marketItem.currentPrice.shortStringRepresentation
    }

    let dataProvider: any MarketDetailsViewDataProviderType

    init(dataProvider: any MarketDetailsViewDataProviderType) {
        self.dataProvider = dataProvider
    }

    func getChartData() {
        Task {
            do {
                try await self.dataProvider.getChartData()
            } catch {
                print(error)
            }
        }
    }
}

final class MarketDetailsViewModel: MarketDetailsViewModelType {
    let dataProvider: any MarketDetailsViewDataProviderType
    var chartDataPublisher: Published<[MarketChartData]>.Publisher {
        dataProvider.chartDataPublisher
    }

    var imageURL: URL {
        dataProvider.marketItem.image
    }

    var symbol: String {
        dataProvider.marketItem.symbol.uppercased()
    }

    var todaysDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        return dateFormatter.string(from: Date())
    }

    var totalValue: String {
        "$" + dataProvider.marketItem.currentPrice.shortStringRepresentation
    }

    init(dataProvider: any MarketDetailsViewDataProviderType) {
        self.dataProvider = dataProvider
    }

    func getChartData() {
        Task {
            do {
                try await self.dataProvider.getChartData()
            } catch {
                print(error)
            }
        }
    }
}
