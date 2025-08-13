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

    public func fetchAssets(homeID: UUID) async throws -> [AssetEntity] { return [] }
    public func add(asset: AssetEntity) async throws {}
    public func update(asset: AssetEntity) async throws {}
    public func delete(asset: AssetEntity) async throws {}
}
#endif
