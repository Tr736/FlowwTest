import SwiftUI

struct MarketsView<ViewModel: MarketsViewModelType>: View {

    @ObservedObject var viewModel: ViewModel
    @State private var items = [MarketResponse]()

    init(viewModel: ViewModel, items: [MarketResponse] = [MarketResponse]()) {
        self.viewModel = viewModel
        self.items = items

        viewModel.getMarketsList()
    }

    var body: some View {
        NavigationStack {
            List(items) { item in
                NavigationLink {
                    let dataProvider = MarketDetailsViewDataProvider(marketItem: item)
                    let viewModel = MarketDetailsViewModel(dataProvider: dataProvider)
                    MarketDetails(viewModel: viewModel)
                } label: {
                    MarketsViewCell(viewModel: MarketsViewCellViewModel(item: item))
                }
            }
            .onReceive(viewModel.marketsPublisher,
                        perform: { output in
                DispatchQueue.main.async {
                    self.items = output.map({ _, value in
                        return value
                    })
                    .sorted(by: { $0.marketCapRank < $1.marketCapRank
                    })
                }
            })

            .navigationTitle("Markets")
            .navigationBarTitleDisplayMode(.large)
            .padding(EdgeInsets(top: 0,
                                leading: -Grid.x4,
                                bottom: 0,
                                trailing: -Grid.x4))


        }
    }
}

struct MarketsView_Previews: PreviewProvider {
    static var previews: some View {
        let dataProvider = MockMarketsDataProvider()
        let viewModel = MockMarketsViewModel(dataProvider: dataProvider)
        MarketsView(viewModel: viewModel)
    }
}
