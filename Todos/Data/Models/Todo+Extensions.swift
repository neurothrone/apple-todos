//
//  Todo+Extensions.swift
//  Todos
//
//  Created by Zaid Neurothrone on 2022-09-14.
//

import CoreData
import Foundation
import SwiftUI
import UIKit

extension Todo {
  static func createWith(
    title: String,
    notes: String,
    priority: Priority,
    deadlineAt: Date?,
    categories: Set<Category> = [],
    image: UIImage? = nil,
    in list: TodoList,
    using context: NSManagedObjectContext
  ) {
    let todo = Todo(context: context)
    todo.title = title
    todo.priority = priority
    todo.categories = categories
    todo.list = list
    
    if notes.isNotEmpty {
      todo.notes = notes
    }
    
    if let deadlineAt = deadlineAt {
      todo.deadlineAt = deadlineAt
    }
    
    // Transformable Approach
    todo.image = image
    
    // Binary Data Approach
//    todo.image = image?.jpegData(compressionQuality: 1) ?? Data()
    
    todo.save(using: context)
  }
  
  // MARK: - Fetch Requests
  static var all: NSFetchRequest<Todo> {
    let request = Todo.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Todo.createdAt, ascending: false)]
    return request
  }
  
  static func todos(in list: TodoList) -> FetchRequest<Todo> {
    let titleSortDescriptor = NSSortDescriptor(keyPath: \TodoList.title, ascending: true)
    let createdAtSortDescriptor = NSSortDescriptor(keyPath: \TodoList.createdAt, ascending: false)
    let listPredicate = NSPredicate(format: "%K == %@", "list.title", list.title)

    //    let combinedPredicate = NSCompoundPredicate(
    //      andPredicateWithSubpredicates: [listPredicate, isCompletePredicate])
    
    return FetchRequest<Todo>(
      entity: Todo.entity(),
      sortDescriptors: [titleSortDescriptor, createdAtSortDescriptor],
      predicate: listPredicate
//      predicate: combinedPredicate
      //      animation: .easeIn
    )
  }
}

// MARK: - SortType
extension Todo {
  enum SortType: Int {
    case createdAt, isComplete, name
    
    static var `default`: SortType {
      .createdAt
    }
    
    func toString() -> String {
      switch self {
      case .createdAt:
        return "Created at"
      case .isComplete:
        return "Completed"
      case .name:
        return "Name"
      }
    }
    
    var title: String {
      "Sorted by \(self.toString())"
    }
  }
}


