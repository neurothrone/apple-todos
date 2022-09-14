//
//  Priority.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-12.
//

import Foundation

enum Priority: Int16 {
  case low, medium, high
}

extension Priority: CaseIterable, Identifiable {
  var id: Priority { self }
}

extension Priority {
  func toString() -> String {
    switch self {
    case .low:
      return "Low"
    case .medium:
      return "Medium"
    case .high:
      return "High"
    }
  }
}
