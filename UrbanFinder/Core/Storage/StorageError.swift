import Foundation

enum StorageError: Error {
    case objectNotFound
    case saveFailed
    case deleteFailed
    case generalError
}
