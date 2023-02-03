
import SwiftUI
import SwiftUICharts
import NukeUI
struct MarketDetails<ViewModel:MarketDetailsViewModelType> : View {
    @ObservedObject var viewModel: ViewModel
    var dataSet: [MarketChartData] = []
    @State var points: [DataPoint] = []

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading,
                   content: {
                HStack {
                    LazyImage(source: viewModel.imageURL)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: Grid.x10)
                    Text(viewModel.symbol)
                        .font(.title)
                        .fontWeight(.bold)
                }
                Text(viewModel.totalValue)
                Text(viewModel.todaysDate)
                LineChartView(dataPoints: points)
                    .chartStyle(
                        LineChartStyle(
                            showLabels: true,
                            labelCount: 5,
                            showLegends: false,
                            drawing: .stroke(width: Grid.xhalf)))
                    .onReceive(viewModel.chartDataPublisher) { values in
                        var points = [DataPoint]()
                        for value in values {
                            let point = DataPoint(value: value.price!,
                                                  label: "\(value.getMonth()!)",
                                                  legend: Legend(color: .blue,
                                                                 label: ""))
                            points.append(point)
                        }
                        self.points = points
                    }
            })
            .padding(EdgeInsets(top: -Grid.x10,
                                leading: Grid.x4,
                                bottom: 0,
                                trailing: Grid.x4))
            .onAppear {
                viewModel.getChartData()
            }
        }
    }
}

struct MarketDetails_Previews: PreviewProvider {
    static var previews: some View {
        let dataProvider = MockMarketDetailsViewDataProvider(marketItem: MarketResponse())
        let viewModel = MockMarketDetailsViewModel(dataProvider: dataProvider)
        MarketDetails(viewModel: viewModel)
    }
}
