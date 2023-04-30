//
//  Persistence.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/10/20.
//
//  https://stackoverflow.com/questions/2230354/any-way-to-pre-populate-core-data
//  https://www.appcoda.com/core-data-preload-sqlite-database/

import CoreData

struct PersistenceController {
    private var appSupportDirectory: URL { FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0] }
    
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Super_Strong")
        
        if isFirstLaunch() {
            print("First launch. Loading preset data")
            let sourceSqliteUrls = [Bundle.main.url(forResource: "Super_Strong", withExtension: "sqlite")!,
                                    Bundle.main.url(forResource: "Super_Strong", withExtension: "sqlite-wal")!,
                                    Bundle.main.url(forResource: "Super_Strong", withExtension: "sqlite-shm")!]
            let destSqliteUrls = [appSupportDirectory.appendingPathComponent("Super_Strong.sqlite"),
                                  appSupportDirectory.appendingPathComponent("Super_Strong.sqlite-wal"),
                                  appSupportDirectory.appendingPathComponent("Super_Strong.sqlite-shm")]
            
            // create Application Support folder if not exists
            try? FileManager.default.createDirectory(at: appSupportDirectory, withIntermediateDirectories: true, attributes: nil)
            
            // copy seed database into location for core data database
            for idx in sourceSqliteUrls.indices {
                try? FileManager.default.copyItem(at: sourceSqliteUrls[idx], to: destSqliteUrls[idx])
            }
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
        
    }

    private func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
