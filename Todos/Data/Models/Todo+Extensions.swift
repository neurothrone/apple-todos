//
//  Todo+Extensions.swift
//  Todos
//
//  Created by Zaid Neurothrone on 2022-09-14.
//

import Foundation

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


