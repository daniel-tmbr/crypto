import CoreData
import Foundation

struct Storage {
    private let container: NSPersistentCloudKitContainer

    init(config: StorageConfig) {
        guard let url = config.bundle.url(forResource: config.name, withExtension: config.extension),
            let managedObjectModel = NSManagedObjectModel(contentsOf: url)
            else { fatalError("\(config.name) xcdatamodeld was not found") }
        container = NSPersistentCloudKitContainer(name: config.name, managedObjectModel: managedObjectModel)
        container.persistentStoreDescriptions = config.descriptions.map { $0.nsStoreDescription() }
        container.viewContext.automaticallyMergesChangesFromParent = true
        do {
            try container.viewContext.setQueryGenerationFrom(.current)
        } catch {
            fatalError("###\(#function): Failed to pin viewContext to the current generation:\(error)")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        do {
              // Uncomment to do a dry run and print the CK records it'll make
            try container.initializeCloudKitSchema(options: [.dryRun, .printSchema])
            // Uncomment to initialize your schema
//            try container.initializeCloudKitSchema()
        } catch {
            print("Unable to initialize CloudKit schema: \(error.localizedDescription)")
        }
    }
    
    public func fetch<Entity: ManagedObject>(_ fetch: Fetch<Entity>) -> FetchedResults<Entity> {
        let context = readContext()
        context.automaticallyMergesChangesFromParent = true
        return FetchedResults(context: context, fetch: fetch)
    }
    
    public func perform<Output>(operation: Operation<Output>) -> ManagedOperation<Output> {
        writeContext().perform(operation)
    }
    
    public func writeContext() -> NSManagedObjectContext {
        let ctx = container.newBackgroundContext()
        try? ctx.setQueryGenerationFrom(.current)
        return ctx
    }
    
    public func readContext() -> NSManagedObjectContext {
        let ctx = container.newBackgroundContext()
        ctx.automaticallyMergesChangesFromParent = true
        return ctx
    }
}

#if DEBUG
extension Storage {
    static var preview: Storage = {
        let result = Storage(config: .memory)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let coin = AssetEntity(context: viewContext)
            coin.name = "Coin\(i)"
            coin.coin = "CN\(i)"
            coin.isTrading = true
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
#endif

fileprivate extension StorageConfig.Description {
    func nsStoreDescription() -> NSPersistentStoreDescription {
        let description = NSPersistentStoreDescription(url: fileUrl)
        description.configuration = configurationName
        if let cloudContainerId = cloudContainerId {
            description.cloudKitContainerOptions = .init(containerIdentifier: cloudContainerId)
        }
        return description
    }
}
