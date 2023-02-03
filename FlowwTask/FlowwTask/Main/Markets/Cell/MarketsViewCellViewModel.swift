import SwiftUI
protocol MarketsViewCellViewModelType: ObservableObject {
    var item: MarketResponse { get }

    var percentChange: (String, Color) { get }
    var currentPrice: String { get }
    var totalValue: String { get }
}

final class MarketsViewCellViewModel: MarketsViewCellViewModelType {
    let item: MarketResponse

    var percentChange: (String, Color) {
        let rounded = round(item.priceChangePercentage24h * 10) / 10
        var color: Color = .black
        if rounded > 0 {
            color = .green
        } else if rounded < 0 {
            color = .red
        }

        return ("\(rounded)%", color)
    }

    var currentPrice: String {
        item.currentPrice.formatted(.currency(code: "USD"))
    }

    var totalValue: String {
        "$" + item.totalVolume.shortStringRepresentation
    }

    init(item: MarketResponse) {
        self.item = item
    }
}

final class MockMarketsViewCellViewModel: MarketsViewCellViewModelType {
    let item: MarketResponse

    var percentChange: (String, Color) {
        let rounded = round(item.priceChangePercentage24h * 10) / 10
        let color = rounded >= 0 ? Color.green: Color.red
        return ("\(rounded)%", color)
    }

    // Always expecting USD
    var currentPrice: String {
        item.currentPrice.formatted(.currency(code: "USD"))
    }

    var totalValue: String {
        "$" + item.totalVolume.shortStringRepresentation
    }

    init(item: MarketResponse) {
        self.item = item
    }
}
