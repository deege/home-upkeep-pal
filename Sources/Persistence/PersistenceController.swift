import Foundation
#if canImport(CoreData)
import CoreData
#endif

/// Core Data stack configured for CloudKit syncing. On non-Apple platforms this is a stub.
public final class PersistenceController {
    public static let shared = PersistenceController()

    #if canImport(CoreData)
    public let container: NSPersistentCloudKitContainer

    private init(inMemory: Bool = false) {
        let modelURL = Bundle.module.url(forResource: "HomeCare", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        container = NSPersistentCloudKitContainer(name: "HomeCare", managedObjectModel: model)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.persistentStoreDescriptions.forEach { desc in
            desc.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            desc.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        }
        container.loadPersistentStores { _, error in
            if let error = error { fatalError("Unresolved error \(error)") }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    #else
    // Dummy initializer for non-CoreData platforms
    private init() {}
    #endif
}
