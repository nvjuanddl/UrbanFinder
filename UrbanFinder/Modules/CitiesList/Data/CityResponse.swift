import Foundation

struct CityResponse {
    let id: String
    let country: String
    let name: String
    let coordinates: CoordinatesResponse
}

extension CityResponse: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = "\(try container.decode(Int.self, forKey: .id))"
        self.country = try container.decode(String.self, forKey: .country)
        self.name = try container.decode(String.self, forKey: .name)
        let coordDTO = try container.decode(CoordinatesResponse.self, forKey: .coordinates)
        self.coordinates = coordDTO
    }
    
    enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case coordinates = "coord"
    }
}
