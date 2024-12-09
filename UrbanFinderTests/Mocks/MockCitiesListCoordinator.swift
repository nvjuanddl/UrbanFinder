@testable import UrbanFinder

final class MockCitiesListCoordinator: CitiesListCoordinatorProtocol {
    var navigateToCityDetailCalledWith: CityUi?

    func navigateToCityDetail(city: CityUi) {
        navigateToCityDetailCalledWith = city
    }
}
