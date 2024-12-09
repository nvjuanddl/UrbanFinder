import XCTest
@testable import UrbanFinder

final class CitiesListViewModelTests: XCTestCase {
    var viewModel: CitiesListViewModel!
    var mockUseCase: MockCitiesListUseCase!
    var mockCoordinator: MockCitiesListCoordinator!

    override func setUp() {
        super.setUp()
        mockUseCase = MockCitiesListUseCase()
        mockCoordinator = MockCitiesListCoordinator()
        viewModel = CitiesListViewModel(useCase: mockUseCase, coordinator: mockCoordinator)
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        mockCoordinator = nil
        super.tearDown()
    }

    func testLoadAndMarkFavoriteCitiesSuccess() async {
        mockUseCase.stubbedCities = [
            CityUi(id: "1", headline: "1", latitude: .zero, longitude: .zero, isFavorite: true, subheadline: ""),
            CityUi(id: "2", headline: "2", latitude: .zero, longitude: .zero, isFavorite: false, subheadline: "")
        ]
        
        await viewModel.loadAndMarkFavoriteCitiesIfPossible()
        
        XCTAssertEqual(viewModel.items.count, 2)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoadAndMarkFavoriteCitiesFailure() async {
        mockUseCase.shouldThrowError = true
        
        await viewModel.loadAndMarkFavoriteCitiesIfPossible()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.items.isEmpty)
    }

    func testSearchReturnsMatchingResults() {
        viewModel.allItems = [
            CityUi(id: "1", headline: "New York", latitude: .zero, longitude: .zero, isFavorite: true, subheadline: ""),
            CityUi(id: "2", headline: "New", latitude: .zero, longitude: .zero, isFavorite: false, subheadline: "")
        ]
        
        viewModel.search(query: "New")
        
        XCTAssertEqual(viewModel.items.count, 2)
        XCTAssertEqual(viewModel.items.first?.headline, "New York")
    }
    
    func testSearchReturnsNoResults() {
        viewModel.allItems = [
            CityUi(id: "1", headline: "New York", latitude: .zero, longitude: .zero, isFavorite: true, subheadline: ""),
            CityUi(id: "2", headline: "Los Angeles", latitude: .zero, longitude: .zero, isFavorite: false, subheadline: "")
        ]
        
        viewModel.search(query: "Chicago")
        
        XCTAssertEqual(viewModel.items.count, 0)
    }

    func testGoToMapCallsCoordinator() {
        let city = CityUi(id: "1", headline: "New York", latitude: .zero, longitude: .zero, isFavorite: true, subheadline: "")
        viewModel.goToMap(with: city)
        
        XCTAssertEqual(mockCoordinator.navigateToCityDetailCalledWith, city)
    }
}
