import XCTest
@testable import FlowwTask

final class GridTest: XCTestCase {
    private enum Constants {
        static let halfX: CGFloat = 2
        static let oneX: CGFloat = 4
        static let twoX: CGFloat = 8
        static let threeX: CGFloat = 12
        static let fourX: CGFloat = 16
        static let fiveX: CGFloat = 20
        static let sixX: CGFloat = 24
        static let sevenX: CGFloat = 28
        static let eightX: CGFloat = 32
        static let nineX: CGFloat = 36
        static let tenX: CGFloat = 40
        static let twentyX: CGFloat = 80
        static let thirtyX: CGFloat = 120
    }

    func test_GridValuesAreCorrect() {
        XCTAssertEqual(Constants.halfX, Grid.xhalf)

        XCTAssertEqual(Constants.oneX, Grid.x1)
        XCTAssertEqual(Constants.twoX, Grid.x2)
        XCTAssertEqual(Constants.threeX, Grid.x3)
        XCTAssertEqual(Constants.fourX, Grid.x4)
        XCTAssertEqual(Constants.fiveX, Grid.x5)
        XCTAssertEqual(Constants.sixX, Grid.x6)
        XCTAssertEqual(Constants.sevenX, Grid.x7)
        XCTAssertEqual(Constants.eightX, Grid.x8)
        XCTAssertEqual(Constants.nineX, Grid.x9)
        XCTAssertEqual(Constants.tenX, Grid.x10)
        XCTAssertEqual(Constants.twentyX, Grid.x20)
        XCTAssertEqual(Constants.thirtyX, Grid.x30)
    }
}
