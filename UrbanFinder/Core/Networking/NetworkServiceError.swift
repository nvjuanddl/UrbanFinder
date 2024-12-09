import Foundation

enum NetworkServiceError: Error {
    case networkConnectionLost
    case notConnectedToInternet
    case decodingError
    case generalError
}

