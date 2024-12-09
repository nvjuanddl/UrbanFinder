import Foundation

struct CoordinatesResponse {
    let lon: Double
    let lat: Double
}

extension CoordinatesResponse: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lon = try container.decode(Double.self, forKey: .lon)
        self.lat = try container.decode(Double.self, forKey: .lat)
    }
    
    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
}
