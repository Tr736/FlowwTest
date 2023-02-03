import XCTest
@testable import FlowwTask
final class Double_Tests: XCTestCase {

    func test_shortStringRep() {
        let oneThousand: Double = 1000
        let twoHundredThousand: Double = 200_000
        let oneMil: Double = 1_000_000
        let oneBil: Double = 1_000_000_000

        XCTAssertEqual(oneThousand.shortStringRepresentation, "1k")
        XCTAssertEqual(twoHundredThousand.shortStringRepresentation, "200k")
        XCTAssertEqual(oneMil.shortStringRepresentation, "1M")
        XCTAssertEqual(oneBil.shortStringRepresentation, "1B")
    }
}
