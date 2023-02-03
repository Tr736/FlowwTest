import XCTest
@testable import FlowwTask
final class MarketChartDataTests: XCTestCase {
    var sut: MarketChartData!
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_getMonth_expectCorrectDateAsMMM_YY(){
        let date = Date.init(timeIntervalSince1970: 900_000_000_000)
        let price: Double = 550
        sut = MarketChartData(date: date, price: price)
        let month = sut.getMonth()

        XCTAssertEqual(month, "Nov 89")
        XCTAssertEqual(sut.price, price)
        XCTAssertEqual(sut.date, date)

    }

}
