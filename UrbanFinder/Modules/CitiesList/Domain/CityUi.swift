import Foundation

class CityUi: CardViewProtocol {
    
    var id: String
    var headline: String
    var subheadline: String
    var latitude: Double
    var longitude: Double
    var isFavorite: Bool
    
    init(
        id: String,
        headline: String,
        latitude: Double,
        longitude: Double,
        isFavorite: Bool,
        subheadline: String
    ) {
        self.id = id
        self.headline = headline
        self.latitude = latitude
        self.longitude = longitude
        self.isFavorite = isFavorite
        self.subheadline = subheadline
    }
}

extension CityUi: Comparable {
    
    static func < (lhs: CityUi, rhs: CityUi) -> Bool {
        lhs.headline < rhs.headline
    }
    
    static func == (lhs: CityUi, rhs: CityUi) -> Bool {
        return lhs.id == rhs.id &&
               lhs.headline == rhs.headline &&
               lhs.latitude == rhs.latitude &&
               lhs.longitude == rhs.longitude &&
               lhs.isFavorite == rhs.isFavorite
    }
}

extension Array where Element == CityResponse {
    
    func asCitiesUi() -> [CityUi] {
        compactMap { item in
            return CityUi(
                id: item.id,
                headline: "\(item.name), \(item.country)",
                latitude: item.coordinates.lat,
                longitude: item.coordinates.lon,
                isFavorite: false,
                subheadline: "\(item.coordinates.lat), \(item.coordinates.lon)"
            )
        }
    }
}
