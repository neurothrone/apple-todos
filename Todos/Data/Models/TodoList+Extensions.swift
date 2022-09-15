//
//  TodoList+Extensions.swift
//  Todos
//
//  Created by Zaid Neurothrone on 2022-09-14.
//

import CoreData
import UIKit

extension TodoList {
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
