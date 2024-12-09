import UIKit

protocol CoordinatorProtocol {
    var dependencyContainer: DependencyContainer { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

class Coordinator: CoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var dependencyContainer: DependencyContainer

    init(
        navigationController: UINavigationController,
        dependencyContainer: DependencyContainer
    ) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }
    
    func start() {
        
    }

    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
