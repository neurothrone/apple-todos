//
//  TodoList+CoreDataProperties.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-13.
//
//

import Foundation
import CoreData
import UIKit


extension TodoList {
    
  @NSManaged public var id: UUID
  @NSManaged public var title: String
  @NSManaged public var color: UIColor?
  @NSManaged public var order: Int16
  @NSManaged public var createdAt: Date
//  @NSManaged public var todos: NSOrderedSet?
  @NSManaged public var todos: [Todo]
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    
    id = UUID()
    order = 0
    createdAt = Date()
  }
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
    return NSFetchRequest<TodoList>(entityName: "TodoList")
  }
  
  static var all: NSFetchRequest<TodoList> {
    let request = TodoList.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
    return request
  }
  
  static func createWith(
    title: String,
    color: UIColor? = nil,
    using managedObjectContext: NSManagedObjectContext
  ) {
    let todoList = self.init(context: managedObjectContext)
    todoList.title = title
    todoList.color = color
    
    CoreDataManager.save(using: managedObjectContext)
  }
}

// MARK: Generated accessors for todos
extension TodoList {
  
  @objc(insertObject:inTodosAtIndex:)
  @NSManaged public func insertIntoTodos(_ value: Todo, at idx: Int)
  
  @objc(removeObjectFromTodosAtIndex:)
  @NSManaged public func removeFromTodos(at idx: Int)
  
  @objc(insertTodos:atIndexes:)
  @NSManaged public func insertIntoTodos(_ values: [Todo], at indexes: NSIndexSet)
  
  @objc(removeTodosAtIndexes:)
  @NSManaged public func removeFromTodos(at indexes: NSIndexSet)
  
  @objc(replaceObjectInTodosAtIndex:withObject:)
  @NSManaged public func replaceTodos(at idx: Int, with value: Todo)
  
  @objc(replaceTodosAtIndexes:withTodos:)
  @NSManaged public func replaceTodos(at indexes: NSIndexSet, with values: [Todo])
  
  @objc(addTodosObject:)
  @NSManaged public func addToTodos(_ value: Todo)
  
  @objc(removeTodosObject:)
  @NSManaged public func removeFromTodos(_ value: Todo)
  
  @objc(addTodos:)
  @NSManaged public func addToTodos(_ values: NSOrderedSet)
  
  @objc(removeTodos:)
  @NSManaged public func removeFromTodos(_ values: NSOrderedSet)
  
}

extension TodoList : Identifiable {}
