class DependencyContainer {
    private var dependencies: [String: Any] = [:]
    
    func register<T>(_ type: T.Type, instance: T) {
        let key = String(describing: type)
        dependencies[key] = instance
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        guard let dependency = dependencies[key] as? T else {
            fatalError("Dependency \(type) has not been registered.")
        }
        return dependency
    }
}
