import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        Task { @MainActor in
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window
            let appCoordinator = AppCoordinator(window: window, dependencyContainer: createDependencyContainer())
            appCoordinator.start()
        }
        return true
    }
    
    @MainActor
    func createDependencyContainer() ->  DependencyContainer {
        let container = DependencyContainer()
        container.register(NetworkDataSource.self, instance: NetworkService())
        if let storageService = StorageService.defaultService(for: CityEntity.self) {
            container.register(StorageDataSource.self, instance: storageService)
        }
        return container
    }
}
