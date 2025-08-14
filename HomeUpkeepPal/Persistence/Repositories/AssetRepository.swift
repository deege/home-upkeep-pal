import Foundation

public protocol AssetRepository {
    func fetchAssets(homeID: UUID) async throws -> [AssetEntity]
    func add(asset: AssetEntity) async throws
    func update(asset: AssetEntity) async throws
    func delete(asset: AssetEntity) async throws
}

#if canImport(CoreData)
import CoreData

public final class CoreDataAssetRepository: AssetRepository {
    private let context: NSManagedObjectContext
    public init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    public func fetchAssets(homeID: UUID) async throws -> [AssetEntity] {
        try await context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Asset")
            request.predicate = NSPredicate(format: "homeID == %@", homeID as CVarArg)
            let objects = try context.fetch(request)
            return objects.compactMap { obj in
                guard let id = obj.value(forKey: "id") as? UUID,
                      let name = obj.value(forKey: "name") as? String,
                      let category = obj.value(forKey: "category") as? String,
                      let created = obj.value(forKey: "createdAt") as? Date,
                      let updated = obj.value(forKey: "updatedAt") as? Date else {
                    return nil
                }
                let location = obj.value(forKey: "location") as? String
                let model = obj.value(forKey: "model") as? String
                let serial = obj.value(forKey: "serial") as? String
                let purchaseDate = obj.value(forKey: "purchaseDate") as? Date
                let warrantyExpiry = obj.value(forKey: "warrantyExpiry") as? Date
                let notes = obj.value(forKey: "notes") as? String
                let photos = obj.value(forKey: "photoFileNames") as? [String] ?? []
                return AssetEntity(id: id,
                                   homeID: homeID,
                                   name: name,
                                   category: AssetEntity.Category(rawValue: category) ?? .other,
                                   location: location,
                                   model: model,
                                   serial: serial,
                                   purchaseDate: purchaseDate,
                                   warrantyExpiry: warrantyExpiry,
                                   notes: notes,
                                   photoFileNames: photos,
                                   createdAt: created,
                                   updatedAt: updated)
            }
        }
    }

    public func add(asset: AssetEntity) async throws {
        try await context.perform {
            let obj = NSEntityDescription.insertNewObject(forEntityName: "Asset", into: context)
            obj.setValue(asset.id, forKey: "id")
            obj.setValue(asset.homeID, forKey: "homeID")
            obj.setValue(asset.name, forKey: "name")
            obj.setValue(asset.category.rawValue, forKey: "category")
            obj.setValue(asset.location, forKey: "location")
            obj.setValue(asset.model, forKey: "model")
            obj.setValue(asset.serial, forKey: "serial")
            obj.setValue(asset.purchaseDate, forKey: "purchaseDate")
            obj.setValue(asset.warrantyExpiry, forKey: "warrantyExpiry")
            obj.setValue(asset.notes, forKey: "notes")
            obj.setValue(asset.photoFileNames, forKey: "photoFileNames")
            obj.setValue(asset.createdAt, forKey: "createdAt")
            obj.setValue(asset.updatedAt, forKey: "updatedAt")

            let homeReq = NSFetchRequest<NSManagedObject>(entityName: "Home")
            homeReq.predicate = NSPredicate(format: "id == %@", asset.homeID as CVarArg)
            if let home = try context.fetch(homeReq).first {
                obj.setValue(home, forKey: "home")
            }
            try context.save()
        }
    }

    public func update(asset: AssetEntity) async throws {
        try await context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Asset")
            request.predicate = NSPredicate(format: "id == %@", asset.id as CVarArg)
            if let obj = try context.fetch(request).first {
                obj.setValue(asset.name, forKey: "name")
                obj.setValue(asset.category.rawValue, forKey: "category")
                obj.setValue(asset.location, forKey: "location")
                obj.setValue(asset.model, forKey: "model")
                obj.setValue(asset.serial, forKey: "serial")
                obj.setValue(asset.purchaseDate, forKey: "purchaseDate")
                obj.setValue(asset.warrantyExpiry, forKey: "warrantyExpiry")
                obj.setValue(asset.notes, forKey: "notes")
                obj.setValue(asset.photoFileNames, forKey: "photoFileNames")
                obj.setValue(asset.updatedAt, forKey: "updatedAt")
                try context.save()
            }
        }
    }

    public func delete(asset: AssetEntity) async throws {
        try await context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Asset")
            request.predicate = NSPredicate(format: "id == %@", asset.id as CVarArg)
            if let obj = try context.fetch(request).first {
                context.delete(obj)
                try context.save()
            }
        }
    }
}
#endif
