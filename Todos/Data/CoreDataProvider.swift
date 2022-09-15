//
//  CoreDataProvider.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-12.
//

import CoreData

struct CoreDataProvider {
  
  // MARK: - Static Properties
  
  static let shared = CoreDataProvider()
  static var preview: CoreDataProvider = {
    let result = CoreDataProvider(inMemory: true)
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
    // Set up Value Transformers for UIColor and UIImage
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

extension CoreDataProvider {
  static func save(using context: NSManagedObjectContext) {
    guard context.hasChanges
    else {
      return
    }
    
    do {
      try context.save()
    } catch {
      context.rollback()
      let nserror = error as NSError
      fatalError("❌ -> \(nserror), \(nserror.userInfo)")
    }
  }
  
  static func delete<T: NSManagedObject>(
    object: T,
    using context: NSManagedObjectContext
  ) {
    context.delete(object)
    save(using: context)
  }
}
