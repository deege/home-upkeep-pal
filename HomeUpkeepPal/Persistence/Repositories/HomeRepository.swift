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

    public func fetchHomes() async throws -> [HomeEntity] {
        try await context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Home")
            let objects = try context.fetch(request)
            return objects.compactMap { obj in
                guard let id = obj.value(forKey: "id") as? UUID,
                      let name = obj.value(forKey: "name") as? String,
                      let created = obj.value(forKey: "createdAt") as? Date,
                      let updated = obj.value(forKey: "updatedAt") as? Date else {
                    return nil
                }
                let address = obj.value(forKey: "address") as? String
                let notes = obj.value(forKey: "notes") as? String
                return HomeEntity(id: id,
                                  name: name,
                                  address: address,
                                  notes: notes,
                                  createdAt: created,
                                  updatedAt: updated)
            }
        }
    }

    public func add(home: HomeEntity) async throws {
        try await context.perform {
            let obj = NSEntityDescription.insertNewObject(forEntityName: "Home", into: context)
            obj.setValue(home.id, forKey: "id")
            obj.setValue(home.name, forKey: "name")
            obj.setValue(home.address, forKey: "address")
            obj.setValue(home.notes, forKey: "notes")
            obj.setValue(home.createdAt, forKey: "createdAt")
            obj.setValue(home.updatedAt, forKey: "updatedAt")
            try context.save()
        }
    }

    public func update(home: HomeEntity) async throws {
        try await context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Home")
            request.predicate = NSPredicate(format: "id == %@", home.id as CVarArg)
            if let obj = try context.fetch(request).first {
                obj.setValue(home.name, forKey: "name")
                obj.setValue(home.address, forKey: "address")
                obj.setValue(home.notes, forKey: "notes")
                obj.setValue(home.updatedAt, forKey: "updatedAt")
                try context.save()
            }
        }
    }

    public func delete(home: HomeEntity) async throws {
        try await context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Home")
            request.predicate = NSPredicate(format: "id == %@", home.id as CVarArg)
            if let obj = try context.fetch(request).first {
                context.delete(obj)
                try context.save()
            }
        }
    }
}
#endif
