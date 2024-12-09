@testable import UrbanFinder

final class MockCitiesListUseCase: CitiesListUseCaseProtocol {
    var stubbedCities: [CityUi] = []
    var stubbedFavoriteCities: [CityUi] = []
    var shouldThrowError: Bool = false
    var toggleFavoriteCalledWith: CityUi?

    func getAllCitiesWithFavorites() async throws -> [CityUi] {
        if shouldThrowError {
            throw NetworkServiceError.notConnectedToInternet
        }
        return stubbedCities
    }

    func toggleFavorite(for city: CityUi) async throws {
        if shouldThrowError {
            throw NetworkServiceError.generalError
        }
        toggleFavoriteCalledWith = city
    }
    
    func getFavoriteCities() async throws -> [CityUi] {
        if shouldThrowError {
            throw NetworkServiceError.generalError
        }
        return stubbedFavoriteCities
    }
}
