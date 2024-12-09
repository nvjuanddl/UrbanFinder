import Foundation
import Combine

protocol NetworkDataSource {
    func fetch<R: NetworkRequest>(_ request: R) async throws -> R.Output
}

final class NetworkService: NetworkDataSource {
        
    lazy private var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        URLCache.shared.diskCapacity = Int.max
        return URLSession(configuration: configuration)
    }()
    
    func fetch<R: NetworkRequest>(_ request: R) async throws -> R.Output {
        do {
            let (data, _) = try await session.data(for: request.urlRequest)
            return try request.decode(data)
        } catch let urlError as URLError {
            switch urlError.code {
            case .networkConnectionLost:
                throw NetworkServiceError.networkConnectionLost
            case .notConnectedToInternet:
                throw NetworkServiceError.notConnectedToInternet
            default:
                throw NetworkServiceError.generalError
            }
        } catch is DecodingError {
            throw NetworkServiceError.decodingError
        } catch {
            throw NetworkServiceError.generalError
        }
    }
}
