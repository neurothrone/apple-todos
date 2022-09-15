//
//  NSManagedObject+Extensions.swift
//  Todos
//
//  Created by Zaid Neurothrone on 2022-09-14.
//

import CoreData

extension NSManagedObject {
  private static var viewContext: NSManagedObjectContext {
    CoreDataManager.shared.viewContext
  }
  
  func save(using context: NSManagedObjectContext) {
    CoreDataManager.save(using: context)
  }
  
  func delete(using context: NSManagedObjectContext) {
    CoreDataManager.delete(object: self, using: context)
  }
  
  static func getById<T: NSManagedObject>(id: UUID) -> T? {
    let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
    request.fetchLimit = 1
    
    do {
      return try viewContext.fetch(request).first
    } catch {
      print("❌ -> Failed to fetch Core Data entity: (\(String(describing: T.self))")
      return nil
    }
  }
  
  static func all<T: NSManagedObject>() -> [T] {
    let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
    
    do {
      return try viewContext.fetch(request)
    } catch {
      print("❌ -> Failed to fetch Core Data entities: (\(String(describing: T.self))")
      return []
    }
  }
}
