import Foundation

struct ConcreteAPI: APIType {
    private let urlSession: URLSessionType
    private let baseURL: URL?
    
    init(baseURL: URL? = URL(string: Endpoints.baseURL),
         urlSession: URLSessionType = URLSession.shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }

    func execute<T>(apiRequest: T) async throws -> T.ResponseBody where T : APIRequest {
        if ConcreteReachability.shared.isReachable == false {
            throw APIError.cannotReachServer
        }
        let data = try await executeRaw(apiRequest: apiRequest).data
        let decoded: T.ResponseBody = try decode(from: data)
        return decoded
    }

    func executeRaw<T>(apiRequest: T) async throws -> (data: Data, response: URLResponse) where T : APIRequest {
        guard let url = try? buildUrl(for: apiRequest) else { throw APIError.invalidUrl(urlString: apiRequest.path )}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRequest.method.rawValue
        urlRequest.setValue(Headers.contentTypeJson,
                         forHTTPHeaderField: Headers.contentType)
        return try await urlSession.data(request: urlRequest)
    }

    private func decode<T>(from data: Data) throws -> T where T: Decodable {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

    private func buildUrl<T: APIRequest>(for apiRequest: T) throws -> URL {
        guard let components = URLComponents(string: apiRequest.path),
              let url = components.url(relativeTo: baseURL) else {
            throw APIError.invalidUrl(urlString: apiRequest.path)
        }
        return url
    }
}

struct MockAPI: APIType {

    private let jsonDecoder = JSONDecoder()

    enum MockAPIError: Error {
        case notImplemented
        case pathNotAddedToMockAPI
    }

    func execute<T>(apiRequest: T) async throws -> T.ResponseBody where T : APIRequest {
        switch apiRequest.path {
        case "prod/mockcredit/values":
            return try jsonDecoder.decode(T.ResponseBody.self, from: MockAPIResponse.loadContents(of: "creditReportInfo", with: "json"))
        default:
            throw MockAPIError.pathNotAddedToMockAPI
        }
    }

    func executeRaw<T>(apiRequest: T) async throws -> (data: Data, response: URLResponse) {
        throw MockAPIError.notImplemented
    }

}

struct MockAPIResponse {
    static func loadContents(of fileNamed: String, with fileType: String) throws -> Data {
        let bundle = Bundle(for: MockMarketsViewModel.self)
        guard let url = bundle.url(forResource: fileNamed, withExtension: fileType) else {
            preconditionFailure("file \(fileNamed) not found in \(bundle.bundlePath)")
        }
        return try Data(contentsOf: url)
    }
}
