//
//  Category+CoreDataProperties.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-13.
//
//

import CoreData

extension Category {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
    return NSFetchRequest<Category>(entityName: String(describing: Category.self))
  }
  
  @NSManaged public var id: UUID
  @NSManaged internal var titleValue: String
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
}

extension Category : Identifiable {}
