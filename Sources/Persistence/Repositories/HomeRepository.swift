import Foundation

/// Protocol defining CRUD operations for Home entities.
public protocol HomeRepository {
    func fetchHomes() async throws -> [HomeEntity]
    func add(home: HomeEntity) async throws
    func update(home: HomeEntity) async throws
    func delete(home: HomeEntity) async throws
}

#if canImport(CoreData)
import CoreData

/// Core Data implementation of HomeRepository.
public final class CoreDataHomeRepository: HomeRepository {
    private let context: NSManagedObjectContext
    public init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    public func fetchHomes() async throws -> [HomeEntity] { return [] }
    public func add(home: HomeEntity) async throws {}
    public func update(home: HomeEntity) async throws {}
    public func delete(home: HomeEntity) async throws {}
}
#endif
