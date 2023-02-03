import Foundation

enum APIError: Error, LocalizedError {
    case invalidUrl(urlString: String)
    case cannotReachServer
}
