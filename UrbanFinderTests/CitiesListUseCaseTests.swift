import XCTest
@testable import UrbanFinder

final class CitiesListUseCaseTests: XCTestCase {
    
    var useCase: CitiesListUseCase!
    var mockRepository: MockCitiesListRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockCitiesListRepository()
        useCase = CitiesListUseCase(repository: mockRepository)
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }

    func testGetAllCitiesWithFavoritesSuccess() async throws {
        mockRepository.stubbedCities = [
            CityResponse(id: "1", country: "US", name: "New York", coordinates: CoordinatesResponse(lon: .zero, lat: .zero)),
            CityResponse(id: "2", country: "US", name: "Miami", coordinates: CoordinatesResponse(lon: .zero, lat: .zero))
        ]
        mockRepository.stubbedFavoriteCities = [CityEntity(id: "2")]
        
        let cities = try await useCase.getAllCitiesWithFavorites()
        
        XCTAssertEqual(cities.count, 2)
        XCTAssertFalse(cities[0].isFavorite)
        XCTAssertTrue(cities[1].isFavorite)
    }

    func testToggleFavoriteAddsFavorite() async throws {
        let city = CityUi(id: "1", headline: "New York", latitude: .zero, longitude: .zero, isFavorite: false, subheadline: "")
        
        try await useCase.toggleFavorite(for: city)
        
        XCTAssertTrue(city.isFavorite)
        XCTAssertEqual(mockRepository.saveFavoriteCityCalledWith?.id, "1")
    }

    func testToggleFavoriteRemovesFavorite() async throws {
        let city = CityUi(id: "1", headline: "New York", latitude: .zero, longitude: .zero, isFavorite: true, subheadline: "")
        mockRepository.stubbedFavoriteCities = [CityEntity(id: "1")]
        
        try await useCase.toggleFavorite(for: city)
        
        XCTAssertFalse(city.isFavorite)
        XCTAssertEqual(mockRepository.deleteFavoriteCityCalledWith?.id, "1")
    }
}
