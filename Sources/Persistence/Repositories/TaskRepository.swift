import Foundation

public protocol TaskRepository {
    func fetchTasks(homeID: UUID) async throws -> [TaskEntity]
    func add(task: TaskEntity) async throws
    func update(task: TaskEntity) async throws
    func delete(task: TaskEntity) async throws
}

#if canImport(CoreData)
import CoreData

public final class CoreDataTaskRepository: TaskRepository {
    private let context: NSManagedObjectContext
    public init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    public func fetchTasks(homeID: UUID) async throws -> [TaskEntity] { return [] }
    public func add(task: TaskEntity) async throws {}
    public func update(task: TaskEntity) async throws {}
    public func delete(task: TaskEntity) async throws {}
}
#endif
