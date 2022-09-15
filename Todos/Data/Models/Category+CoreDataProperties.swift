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
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    
    id = UUID()
  }
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
    return NSFetchRequest<Category>(entityName: "Category")
  }
}

extension Category : Identifiable {}
