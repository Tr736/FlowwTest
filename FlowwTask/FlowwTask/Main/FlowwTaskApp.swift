import SwiftUI

@main
struct FlowwTaskApp: App {
    var body: some Scene {
        WindowGroup {
            let dataProvider = MarketsDataProvider()
            let viewModel = MarketsViewModel(dataProvider: dataProvider)
            MarketsView(viewModel: viewModel)
        }
    }
}
