//
//  CategoryListModal.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-13.
//

import SwiftUI

struct CategoryListModal: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  let categories: [Category]
  
  var body: some View {
    NavigationView {
      List {
        Section {
          ForEach(categories) { category in
            Text("\(category.title) (") + Text( "\(category.todosCount)").bold().foregroundColor(.accentColor) + Text(")")
          }
        }
      }
      .navigationTitle("Categories")
    }
  }
}

struct CategoryListModal_Previews: PreviewProvider {
  static var previews: some View {
    let context = CoreDataProvider.preview.viewContext
    let category = Category(context: context)
    category.title = "Groceries"
    
    return CategoryListModal(categories: [category])
      .environment(\.managedObjectContext, context)
  }
}
