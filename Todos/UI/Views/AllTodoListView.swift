//
//  AllTodoListView.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-13.
//

import SwiftUI

struct AllTodoListView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  let todoLists: FetchedResults<TodoList>
  
  var body: some View {
    List {
      Section {
        ForEach(todoLists) { todoList in
          NavigationLink {
            TodoListScreen(todoList: todoList)
          } label: {
            HStack {
              CircularView(color:  Color(uiColor: todoList.color ?? .clear))
              Text("\(todoList.title)")
            }
          }
        }
        .onDelete(perform: delete)
      } header: {
        Text("Todo Lists")
      } footer: {
        Text("\(todoLists.count) lists")
          .alignToRight
      }
    }
  }
}

extension AllTodoListView {
  private func delete(at offsets: IndexSet) {
    guard let index = offsets.first
    else {
      print("❌ -> Failed to get first index of TodoLists.")
      return
    }
    
    todoLists[index].delete(using: viewContext)
  }
}

struct AllTodoListView_Previews: PreviewProvider {
  @FetchRequest(fetchRequest: TodoList.all) private static var allTodoLists
  
  static var previews: some View {
    let context = CoreDataManager.preview.viewContext
    
    return AllTodoListView(todoLists: allTodoLists)
      .environment(\.managedObjectContext, context)
  }
}
