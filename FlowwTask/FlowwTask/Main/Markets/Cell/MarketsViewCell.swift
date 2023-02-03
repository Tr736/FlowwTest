import SwiftUI
import NukeUI

struct MarketsViewCell<ViewModel: MarketsViewCellViewModelType>: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        HStack {
            Text("#\(viewModel.item.marketCapRank)")
                .foregroundColor(.secondary)
                .font(.title2)
            LazyImage(source: viewModel.item.image)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: Grid.x10)

            VStack(alignment: .leading, content: {
                Text(viewModel.item.symbol.uppercased())
                Text(viewModel.totalValue)
                    .foregroundColor(.gray)
            })
            Spacer()
            VStack(alignment: .trailing, content: {
                Text(viewModel.currentPrice)
                Text(viewModel.percentChange.0)
                    .foregroundColor(viewModel.percentChange.1)
            })
        }
    }
}

struct MarketsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        let response = MarketResponse()
        let viewModel = MockMarketsViewCellViewModel(item: response)
        MarketsViewCell(viewModel: viewModel)
    }
}
