import Foundation
import SwiftData

protocol CitiesListRepositoryProtocol {
    func getCitiesList() async throws -> [CityResponse]
    func getFavoriteCities() async throws -> [CityEntity]
    func saveFavoriteCity(_ city: CityEntity) async throws
    func deleteFavoriteCity(_ city: CityEntity) async throws
    func getFavoriteCity(with id: String) async throws -> CityEntity
}

final class CitiesListRepository: CitiesListRepositoryProtocol {
    
    private let apiService: NetworkDataSource
    private let storageService: StorageDataSource
    
    init(
        apiService: NetworkDataSource = NetworkService(),
        storageService: StorageDataSource
    ) {
        self.apiService = apiService
        self.storageService = storageService
    }

    func getCitiesList() async throws -> [CityResponse] {
        return try await apiService.fetch(CitiesListRequest())
    }
    
    func getFavoriteCities() async throws -> [CityEntity] {
        return try await storageService.fetchAll(CityEntity.self)
    }
    
    func saveFavoriteCity(_ city: CityEntity) async throws {
        try await storageService.save(city)
    }
    
    func deleteFavoriteCity(_ city: CityEntity) async throws {
        try await storageService.delete(city)
    }
    
    func getFavoriteCity(with id: String) async throws -> CityEntity {
        let favoriteCities = try await getFavoriteCities()
        guard let cityEntity = favoriteCities.first(where: { $0.id == id }) else { throw CitiesListError.cityNotFound }
        return cityEntity
    }
}
