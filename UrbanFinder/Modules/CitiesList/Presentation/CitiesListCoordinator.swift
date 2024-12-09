import UIKit

protocol CitiesListCoordinatorProtocol: AnyObject {
    func navigateToCityDetail(city: CityUi)
}

class CitiesListCoordinator: Coordinator, CitiesListCoordinatorProtocol {
    
    override init(navigationController: UINavigationController, dependencyContainer: DependencyContainer) {
        super.init(navigationController: navigationController, dependencyContainer: dependencyContainer)
    }
    
    override func start() {
        let storageService = dependencyContainer.resolve(StorageDataSource.self)
        let networkService = dependencyContainer.resolve(NetworkDataSource.self)
        let repository = CitiesListRepository(apiService: networkService, storageService: storageService)
        let useCase = CitiesListUseCase(repository: repository)
        let viewModel = CitiesListViewModel(useCase: useCase, coordinator: self)
        let viewController = WrapperViewController(rootView: CitiesListView(viewModel: viewModel))
        navigationController.setViewControllers([viewController], animated: true)
        addChildCoordinator(self)
    }
    
    func navigateToCityDetail(city: CityUi) {
        let coordinates = CoordinatesUi(latitude: city.latitude, longitude: city.longitude)
        let coordinator = MapViewCoordinator(coordinate: coordinates, navigationController: navigationController, dependencyContainer: dependencyContainer)
        coordinator.start()
    }
}
