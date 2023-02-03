import XCTest
@testable import FlowwTask
class ConcreteAPITests: XCTestCase {
    private enum Constants {
        static let timeout: TimeInterval = 10
        static let baseURL = "https://mock.com"
        static let getRequestExpectation = "Get request expectation"
        static let expectationDecoded = "Decodable expectation"
        static let expectationFailedToDecode = "Failed to decode expectation"
        static let responseStatusCode = 200
        static let name = "Homer"
        static let age = 26
    }
    private var sut: ConcreteAPI!
    private var mockURLSession: MockUrlSession!
    private let baseURL = URL(string: Constants.baseURL)!
    private var decodedData: TestResponseObject?

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockURLSession = nil
    }

    func test_getRequest() {
        let responseObject = APIRequestEmptyObject()
        let json = try! JSONEncoder().encode(responseObject)
        mockURLSession = MockUrlSession(responseObject: json,
                                        responseStatusCode: Constants.responseStatusCode)
        sut = ConcreteAPI(baseURL: baseURL,
                          urlSession: mockURLSession)

        let expectation = expectation(description: Constants.getRequestExpectation)
        let request = GetRequest()
        Task {
            do {
              _ =  try await sut.execute(apiRequest: request)
            } catch {
                XCTFail(String(describing: error))
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: Constants.timeout)
    }

    func test_GetRequest_IsDecodable() {
        let responseObject = TestResponseObject(name: Constants.name,
                                                age: Constants.age)
        let json = try! JSONEncoder().encode(responseObject)
        mockURLSession = MockUrlSession(responseObject: json,
                                        responseStatusCode: Constants.responseStatusCode)
        sut = ConcreteAPI(baseURL: baseURL,
                          urlSession: mockURLSession)

        let expectation = expectation(description: Constants.expectationDecoded)
        let request = GetRequestWithObject()
        Task {
            do {
                self.decodedData = try await sut.execute(apiRequest: request)
            } catch {
                XCTFail(String(describing: error))
            }
            expectation.fulfill()

        }
        waitForExpectations(timeout: Constants.timeout)

        XCTAssertEqual(self.decodedData?.age, Constants.age)
        XCTAssertEqual(self.decodedData?.name, Constants.name)
    }

    func test_GetRequest_failedToDecode() {
        let responseObject = APIRequestEmptyObject()
        let json = try! JSONEncoder().encode(responseObject)
        mockURLSession = MockUrlSession(responseObject: json,
                                        responseStatusCode: Constants.responseStatusCode)
        sut = ConcreteAPI(baseURL: baseURL,
                          urlSession: mockURLSession)

        let expectation = expectation(description: Constants.expectationFailedToDecode)
        let request = GetRequestWithObject()
        Task {
            do {
                self.decodedData = try await sut.execute(apiRequest: request)
            } catch let DecodingError.keyNotFound(key, context) {
                XCTAssertNotNil(key)
                XCTAssertNotNil(context)
            }
            expectation.fulfill()

        }
        waitForExpectations(timeout: Constants.timeout)
    }
}
