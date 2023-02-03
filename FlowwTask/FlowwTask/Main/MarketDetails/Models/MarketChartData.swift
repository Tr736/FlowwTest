import Foundation
struct MarketChartData {
    let date: Date?
    let price: Double?

    func getMonth() -> String? {
        guard let date = self.date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM YY"
        return dateFormatter.string(from: date)
    }
}
