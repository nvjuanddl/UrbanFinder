@testable import UrbanFinder

final class MockCitiesListRepository: CitiesListRepositoryProtocol {
    var stubbedCities: [CityResponse] = []
    var stubbedFavoriteCities: [CityEntity] = []
    var saveFavoriteCityCalledWith: CityEntity?
    var deleteFavoriteCityCalledWith: CityEntity?

    func getCitiesList() async throws -> [CityResponse] {
        return stubbedCities
    }

    func getFavoriteCities() async throws -> [CityEntity] {
        return stubbedFavoriteCities
    }

    func saveFavoriteCity(_ city: CityEntity) async throws {
        saveFavoriteCityCalledWith = city
    }

    func deleteFavoriteCity(_ city: CityEntity) async throws {
        deleteFavoriteCityCalledWith = city
    }

    func getFavoriteCity(with id: String) async throws -> CityEntity {
        return stubbedFavoriteCities.first(where: { $0.id == id }) ?? CityEntity(id: "")
    }
}
