//
//  AllTodoListView.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-13.
//

import SwiftUI

struct AllTodoListView: View {
  let todoLists: FetchedResults<TodoList>
  
  var body: some View {
    List {
      Section {
        ForEach(todoLists) { todoList in
          NavigationLink {
            TodoListScreen(todoList: todoList)
          } label: {
            HStack {
              CircularView(color: .purple)
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
      print("❌ -> Failed to get first index")
      return
    }
    
    CoreDataManager.deleteList(todoLists[index])
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
