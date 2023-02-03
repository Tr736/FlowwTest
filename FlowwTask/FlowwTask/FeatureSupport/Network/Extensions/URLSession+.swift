
import Foundation

extension URLSession: URLSessionType {
    func data(request: URLRequest) async throws -> (Data, URLResponse) {
        try await self.data(for: request)
    }
}
