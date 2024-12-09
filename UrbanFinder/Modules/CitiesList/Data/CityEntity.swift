import SwiftData

@Model
class CityEntity: Persistable {
    @Attribute(.unique) var id: String
    
    init(id: String) {
        self.id = id
    }
}
