
import XCTest
@testable import FlowwTask
final class MarketChartRequestTest: XCTestCase {
    private enum Constants {
        static let id: String = "bitcoin"
        static let path: String = "v3/coins/bitcoin/market_chart?vs_currency=usd&days=365&interval=daily"
    }
    var sut: MarketChartRequest!

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_hasCorrectPathAndMethod() {
        sut = MarketChartRequest(id: Constants.id)
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, Constants.path)
    }

}
