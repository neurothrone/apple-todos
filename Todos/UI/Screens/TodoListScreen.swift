//
//  TodoListScreen.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-13.
//

import SwiftUI

struct TodoListScreen: View {
  
  @State private var isCreateModalPresented = false
  
  let todoList: TodoList
  
  var body: some View {
    AllTodoView(todoList: todoList)
      .navigationTitle(todoList.title)
      .sheet(isPresented: $isCreateModalPresented) {
        AddTodoModal(todoList: todoList)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            isCreateModalPresented.toggle()
          } label: {
            Image(systemName: "plus")
          }
        }
      }
  }
}

struct TodoListScreen_Previews: PreviewProvider {
  static var previews: some View {
    let context = CoreDataManager.preview.viewContext
    let todoList = TodoList(context: context)
    todoList.title = "Preview List"
    CoreDataManager.save(using: context)
    
    return TodoListScreen(todoList: todoList)
      .environment(\.managedObjectContext, context)
  }
}
