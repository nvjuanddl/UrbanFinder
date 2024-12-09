import Foundation

protocol CitiesListUseCaseProtocol {
    func getAllCitiesWithFavorites() async throws -> [CityUi]
    func getFavoriteCities() async throws -> [CityUi]
    func toggleFavorite(for city: CityUi) async throws
}

final class CitiesListUseCase: CitiesListUseCaseProtocol {
    
    private let repository: CitiesListRepositoryProtocol
    
    init(repository: CitiesListRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllCitiesWithFavorites() async throws -> [CityUi] {
        let cities = try await repository.getCitiesList().asCitiesUi()
        let favoriteCities = (try? await repository.getFavoriteCities().compactMap { $0.id }) ?? []
        return cities.map { city in
            city.isFavorite = favoriteCities.contains { $0 == city.id }
            return city
        }
    }
    
    func getFavoriteCities() async throws -> [CityUi] {
        let cities = try await repository.getCitiesList().asCitiesUi()
        let favoriteCitiesSet = Set((try? await repository.getFavoriteCities().compactMap { $0.id }) ?? [])
        
        return cities.compactMap { city in
            if favoriteCitiesSet.contains(city.id) {
                city.isFavorite = true
                return city
            }
            return nil
        }
    }
    
    func toggleFavorite(for city: CityUi) async throws {
        if city.isFavorite {
            try await deleteFavoriteCity(city)
        } else {
            try await saveFavoriteCity(city)
        }
    }
    
    private func saveFavoriteCity(_ city: CityUi) async throws {
        let cityEntity = CityEntity(id: city.id)
        try await repository.saveFavoriteCity(cityEntity)
        city.isFavorite = true
    }
    
    private func deleteFavoriteCity(_ city: CityUi) async throws {
        let cityEntity = try await repository.getFavoriteCity(with: city.id)
        try await repository.deleteFavoriteCity(cityEntity)
        city.isFavorite = false
    }
}
