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

    public func fetchTasks(homeID: UUID) async throws -> [TaskEntity] {
        try await context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Task")
            request.predicate = NSPredicate(format: "homeID == %@", homeID as CVarArg)
            let objects = try context.fetch(request)
            return objects.compactMap { obj in
                guard let id = obj.value(forKey: "id") as? UUID,
                      let title = obj.value(forKey: "title") as? String,
                      let frequency = obj.value(forKey: "frequencyDays") as? Int,
                      let nextDue = obj.value(forKey: "nextDueAt") as? Date,
                      let isArchived = obj.value(forKey: "isArchived") as? Bool,
                      let created = obj.value(forKey: "createdAt") as? Date,
                      let updated = obj.value(forKey: "updatedAt") as? Date else { return nil }
                let assetID = obj.value(forKey: "assetID") as? UUID
                let notes = obj.value(forKey: "notes") as? String
                let lastDone = obj.value(forKey: "lastDoneAt") as? Date
                return TaskEntity(id: id,
                                  homeID: homeID,
                                  assetID: assetID,
                                  title: title,
                                  notes: notes,
                                  frequencyDays: frequency,
                                  lastDoneAt: lastDone,
                                  nextDueAt: nextDue,
                                  isArchived: isArchived,
                                  createdAt: created,
                                  updatedAt: updated)
            }
        }
    }

    public func add(task: TaskEntity) async throws {
        try await context.perform {
            let obj = NSEntityDescription.insertNewObject(forEntityName: "Task", into: context)
            obj.setValue(task.id, forKey: "id")
            obj.setValue(task.homeID, forKey: "homeID")
            obj.setValue(task.assetID, forKey: "assetID")
            obj.setValue(task.title, forKey: "title")
            obj.setValue(task.notes, forKey: "notes")
            obj.setValue(task.frequencyDays, forKey: "frequencyDays")
            obj.setValue(task.lastDoneAt, forKey: "lastDoneAt")
            obj.setValue(task.nextDueAt, forKey: "nextDueAt")
            obj.setValue(task.isArchived, forKey: "isArchived")
            obj.setValue(task.createdAt, forKey: "createdAt")
            obj.setValue(task.updatedAt, forKey: "updatedAt")

            let homeReq = NSFetchRequest<NSManagedObject>(entityName: "Home")
            homeReq.predicate = NSPredicate(format: "id == %@", task.homeID as CVarArg)
            if let home = try context.fetch(homeReq).first {
                obj.setValue(home, forKey: "home")
            }
            if let assetID = task.assetID {
                let assetReq = NSFetchRequest<NSManagedObject>(entityName: "Asset")
                assetReq.predicate = NSPredicate(format: "id == %@", assetID as CVarArg)
                if let asset = try context.fetch(assetReq).first {
                    obj.setValue(asset, forKey: "asset")
                }
            }
            try context.save()
        }
    }

    public func update(task: TaskEntity) async throws {
        try await context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Task")
            request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
            if let obj = try context.fetch(request).first {
                obj.setValue(task.title, forKey: "title")
                obj.setValue(task.notes, forKey: "notes")
                obj.setValue(task.frequencyDays, forKey: "frequencyDays")
                obj.setValue(task.lastDoneAt, forKey: "lastDoneAt")
                obj.setValue(task.nextDueAt, forKey: "nextDueAt")
                obj.setValue(task.isArchived, forKey: "isArchived")
                obj.setValue(task.updatedAt, forKey: "updatedAt")
                try context.save()
            }
        }
    }

    public func delete(task: TaskEntity) async throws {
        try await context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Task")
            request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
            if let obj = try context.fetch(request).first {
                context.delete(obj)
                try context.save()
            }
        }
    }
}
#endif
