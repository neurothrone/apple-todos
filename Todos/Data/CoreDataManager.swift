//
//  CoreDataManager.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-12.
//

import CoreData

struct CoreDataManager {
  
  // MARK: - Static Properties
  
  static let shared = CoreDataManager()
  static var preview: CoreDataManager = {
    let result = CoreDataManager(inMemory: true)
    let viewContext = result.container.viewContext
    
    //    for i in 1...5 {
    //      let todo = Todo(context: viewContext)
    //      todo.title = "Todo \(i)"
    //      todo.isComplete = i % 2 == 0
    //    }
    
    //    save(using: viewContext)
    
    return result
  }()
  
  // MARK: - Initialisation
  
  private let container: NSPersistentContainer
  
  private init(inMemory: Bool = false) {
    ValueTransformer.setValueTransformer(
      UIColorTransformer(),
      forName: NSValueTransformerName(String(describing: UIColorTransformer.self))
    )
    
    ValueTransformer.setValueTransformer(
      UIImageTransformer(),
      forName: NSValueTransformerName(String(describing: UIImageTransformer.self))
    )
    
    container = NSPersistentContainer(name: "Entities")
    
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("❌ -> Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.name = "viewContext"
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true
  }
  
  var viewContext: NSManagedObjectContext {
    container.viewContext
  }
  
  private func newBackgroundContext() -> NSManagedObjectContext {
    let context = container.newBackgroundContext()
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return context
  }
  
  //  func getAllTodoLists() async throws -> [TodoList] {
  //    let backgroundContext = newBackgroundContext()
  //    backgroundContext.name = "backgroundContext"
  //    backgroundContext.transactionAuthor = "getAllTodoLists"
  //
  //    try backgroundContext.performAndWait {
  //      // create request
  //      // fetch results
  //      // return results
  //    }
  //
  //    return []
  //  }
}

extension CoreDataManager {
  static func save(using managedObjectContext: NSManagedObjectContext) {
    guard managedObjectContext.hasChanges
    else {
      return
    }
    
    do {
      try managedObjectContext.save()
    } catch {
      let nserror = error as NSError
      fatalError("❌ -> \(nserror), \(nserror.userInfo)")
    }
  }
  
  static func deleteList(_ list: TodoList) {
    let context = shared.viewContext
    context.delete(list)
    save(using: context)
  }
}
