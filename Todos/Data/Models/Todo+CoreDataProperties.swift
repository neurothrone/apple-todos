//
//  Todo+CoreDataProperties.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-12.
//
//

import CoreData
import UIKit

// NOTE:
// When using the Transformable approach you don't have to implement a custom value transformer if
// an object inherits from NSObject and implements the NSCoding protocol. In that case Core Data will
// transform automatically for you, e.g. UIImage and UIColor.

// TODO: Attachment entity
// Concept of faulting: Change image to URI type and reference it on the Todo entity
// Then e.g. when accessing the detail view of a Todo, load it from
// external storage. This is more ideal/optimal

extension Todo {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
    return NSFetchRequest<Todo>(entityName: String(describing: Todo.self))
  }
  
  // MARK: - Properties
  
  @NSManaged public var id: UUID
  @NSManaged public var title: String
  @NSManaged public var notes: String?
  @NSManaged public var createdAt: Date
  @NSManaged public var deadlineAt: Date?
  @NSManaged public var isComplete: Bool
  @NSManaged public var order: Int16
  
  @NSManaged fileprivate var priorityValue: Int16
  var priority: Priority {
    get { Priority(rawValue: priorityValue) ?? .medium }
    set { priorityValue = newValue.rawValue }
  }
  
  // Transformable Approach
  @NSManaged public var image: UIImage?
  
  // Binary Data Approach
  // With 'Allows External Storage' checked, the data can be stored on the iOS file system
  // instead of in the persistent store. Which is a great advantage when it comes to media files,
  // such as images and videos as they take large amount of space. Core Data will maintain a
  // reference to the data in that case.
  
  // Persistent store = < 10 mb
  // File system = >= 10 mb
//  @NSManaged public var image: Data?
  
  // MARK: - Relationships
  @NSManaged public var list: TodoList
  @NSManaged public var categories: Set<Category>?
  
  // MARK: - Methods
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    
    id = UUID()
    isComplete = false
    order = 0
    createdAt = Date()
  }
}

extension Todo : Identifiable {}
