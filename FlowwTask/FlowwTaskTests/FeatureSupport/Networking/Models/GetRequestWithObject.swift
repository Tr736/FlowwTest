import Foundation
@testable import FlowwTask
struct GetRequestWithObject: APIRequest {
    typealias ResponseBody = TestResponseObject

    let method = RequestMethod.get
    let path = "testPath/foo/bar"
}
