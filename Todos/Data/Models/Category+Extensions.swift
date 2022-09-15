//
//  Category+Extensions.swift
//  Todos
//
//  Created by Zaid Neurothrone on 2022-09-14.
//

import CoreData

extension Category {
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
