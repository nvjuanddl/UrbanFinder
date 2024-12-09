import SwiftData
import Foundation

protocol StorageDataSource {
    func save<T: Persistable>(_ object: T) async throws
    func fetchAll<T: Persistable>(_ type: T.Type) async throws -> [T]
    func delete<T: Persistable>(_ object: T) async throws
}

protocol Persistable: PersistentModel where ID: Hashable {
    var id: ID { get }
}

@MainActor
final class StorageService: StorageDataSource {

    private let container: ModelContainer
    var context: ModelContext { container.mainContext }
    
    init(container: ModelContainer) {
        self.container = container
    }

    func save<T: Persistable>(_ object: T) async throws {
        context.insert(object)
        try context.save()
    }

    func fetchAll<T: Persistable>(_ type: T.Type) async throws -> [T] {
        return try context.fetch(FetchDescriptor<T>())
    }

    func delete<T: Persistable>(_ object: T) async throws {
        context.delete(object)
        try context.save()
    }
}

extension StorageService {
    
    @MainActor
    static func defaultService<T: PersistentModel>(for type: T.Type) -> StorageService? {
        do {
            let container = try ModelContainer(for: type)
            return StorageService(container: container)
        } catch {
            return nil
        }
    }
}


