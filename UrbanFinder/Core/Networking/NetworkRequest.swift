import Foundation

protocol NetworkRequest {
    associatedtype Output
    var url: URL { get }
    var parameters: Encodable? { get }
    var method: HTTPMethod { get }
    func decode(_ data: Data) throws -> Output
}

extension NetworkRequest where Output: Decodable {
    
    func decode(_ data: Data) throws -> Output {
        let decoder = JSONDecoder()
        return try decoder.decode(Output.self, from: data)
    }
}

extension NetworkRequest {
    
    var parameters: Encodable? { nil }
    
    var urlRequest: URLRequest {
        var urlRequest: URLRequest
        
        guard let parameters else {
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            return urlRequest
        }
        
        if method == .get, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            urlComponents.queryItems = parameters.asDictionary().compactMap({ URLQueryItem(name: $0.key, value: $0.value as? String)} )
            urlRequest = URLRequest(url: urlComponents.url!)
        } else {
            urlRequest = URLRequest(url: url)
            urlRequest.httpBody = parameters.encode()
        }
        
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
