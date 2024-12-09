import UIKit

class MapViewCoordinator: Coordinator {
    
    var coordinate: CoordinatesUi

    init(
        coordinate: CoordinatesUi,
        navigationController: UINavigationController,
        dependencyContainer: DependencyContainer
    ) {
        self.coordinate = coordinate
        super.init(navigationController: navigationController, dependencyContainer: dependencyContainer)
    }
    
    override func start() {
        let viewModel = MapViewModel(coordinate: coordinate, coordinator: self)
        let viewController = WrapperViewController(rootView: MapView(viewModel: viewModel))
        addChildCoordinator(self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
