import Foundation
// This would normally sit in a shared module
protocol APIType {
    func execute<T: APIRequest>(apiRequest: T) async throws -> T.ResponseBody
    func executeRaw<T: APIRequest>(apiRequest: T) async throws -> (data: Data, response: URLResponse)

}
