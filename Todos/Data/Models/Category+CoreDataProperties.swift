//
//  Category+CoreDataProperties.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-13.
//
//

import Foundation
import CoreData


extension Category {
  
  // MARK: - Properties
  
  @NSManaged public var id: UUID
  
  @NSManaged fileprivate var titleValue: String
  var title: String {
    get { titleValue.capitalized }
    set { titleValue = newValue.lowercased() }
  }
  
  @NSManaged public var todos: Set<Todo>
  
  @objc var todosCount: Int {
    willAccessValue(forKey: "todos")
    let count = todos.count
    didAccessValue(forKey: "todos")
    return count
  }
  
  // MARK: - Methods
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    
    id = UUID()
  }
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
    return NSFetchRequest<Category>(entityName: "Category")
  }
  
  static func fetchOrCreateWith(
    title: String,
    using context: NSManagedObjectContext
  ) -> Category {
    let processedTitle = title.trimmingCharacters(in: .whitespaces).lowercased()
    
    let request: NSFetchRequest<Category> = fetchRequest()
    let predicate = NSPredicate(format: "%K == %@", "titleValue", processedTitle)
    request.predicate = predicate
    
    do {
      let results = try context.fetch(request)
      
      if let foundCategory = results.first {
        return foundCategory
      } else {
        let newCategory = Category(context: context)
        newCategory.title = title
        
        CoreDataManager.save(using: context)
        
        return newCategory
      }
    } catch {
      fatalError("❌ -> Error when requesting category: \(error.localizedDescription)")
    }
  }
}

// MARK: Generated accessors for todos
extension Category {
  
  @objc(addTodosObject:)
  @NSManaged public func addToTodos(_ value: Todo)
  
  @objc(removeTodosObject:)
  @NSManaged public func removeFromTodos(_ value: Todo)
  
  @objc(addTodos:)
  @NSManaged public func addToTodos(_ values: NSSet)
  
  @objc(removeTodos:)
  @NSManaged public func removeFromTodos(_ values: NSSet)
  
}

extension Category : Identifiable {}
