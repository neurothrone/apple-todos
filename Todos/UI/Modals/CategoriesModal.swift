//
//  CategoriesModal.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-13.
//

import SwiftUI

struct CategoriesModal: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  let categories: [Category]
  
  var body: some View {
    NavigationView {
      List {
        Section {
          ForEach(categories) { category in
            Text("\(category.title) (\(category.todosCount))")
          }
        }
      }
      .navigationTitle("Categories")
    }
  }
}

struct CategoriesModal_Previews: PreviewProvider {
  static var previews: some View {
    let context = CoreDataManager.preview.viewContext
    let category = Category(context: context)
    category.title = "Groceries"
    
    return CategoriesModal(categories: [category])
      .environment(\.managedObjectContext, context)
  }
}
