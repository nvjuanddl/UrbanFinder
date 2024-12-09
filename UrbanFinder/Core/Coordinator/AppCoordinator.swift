import UIKit

class AppCoordinator: Coordinator {
        
    var window: UIWindow
    
    @MainActor
    init(window: UIWindow, dependencyContainer: DependencyContainer) {
        self.window = window
        super.init(navigationController: UINavigationController(), dependencyContainer: dependencyContainer)
    }

    override func start() {
        let coordinator = CitiesListCoordinator(navigationController: navigationController, dependencyContainer: dependencyContainer)
        addChildCoordinator(coordinator)
        coordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
