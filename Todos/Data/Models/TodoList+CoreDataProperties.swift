//
//  TodoList+CoreDataProperties.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-13.
//
//

import CoreData
import UIKit

extension TodoList {
    
  @NSManaged public var id: UUID
  @NSManaged public var title: String
  @NSManaged public var color: UIColor?
  @NSManaged public var order: Int16
  @NSManaged public var createdAt: Date
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
}

extension TodoList : Identifiable {}
