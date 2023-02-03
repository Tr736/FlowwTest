import Foundation
protocol MarketsViewModelType: ObservableObject {
    var errorPublisher: Published<Error?>.Publisher { get }
    var marketsPublisher: Published<[String: MarketResponse]>.Publisher { get }

    var dataProvider: any MarketsDataProviderType { get }
    func getMarketsList()
}

final class MockMarketsViewModel: MarketsViewModelType {
    //MARK: Error Handling
    @Published var error: Error?
    var errorPublisher: Published<Error?>.Publisher {
        $error
    }
    //MARK: Data observer
    var marketsPublisher: Published<[String: MarketResponse]>.Publisher {
        $marketResponse
    }
    @Published private var marketResponse: [String: MarketResponse] = [:]


    let dataProvider: any MarketsDataProviderType

    init(dataProvider: any MarketsDataProviderType) {
        self.dataProvider = dataProvider
    }

    func getMarketsList() {
        Task {
            do {
                let request = try await dataProvider.getMarketsList()
                request.forEach { response in
                    self.marketResponse[response.id] = response
                }
            } catch {
                await MainActor.run(body: {
                    self.error = error
                })
            }
        }
    }
}

final class MarketsViewModel: MarketsViewModelType {
    //MARK: Error Handling
    @Published var error: Error?
    var errorPublisher: Published<Error?>.Publisher {
        $error
    }

    //MARK: Data observer
    var marketsPublisher: Published<[String: MarketResponse]>.Publisher {
        $marketResponse
    }
    @Published private var marketResponse: [String: MarketResponse] = [:]

    let dataProvider: any MarketsDataProviderType

    init(dataProvider: any MarketsDataProviderType) {
        self.dataProvider = dataProvider
    }

    func getMarketsList() {
        Task {
            do {
                let request = try await dataProvider.getMarketsList()
                await MainActor.run(body: {
                    request.forEach {  response in
                        self.marketResponse[response.id] = response
                    }
                })

            } catch {
                await MainActor.run(body: {
                    self.error = error
                })
            }
        }
    }
}
