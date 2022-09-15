//
//  AllTodoView.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-12.
//

import SwiftUI

struct AllTodoView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @State private var isCategoriesModalPresented = false
  @State private var activeSortIndex = Todo.SortType.default.rawValue
  
  let todoList: TodoList
  let todosFetchRequest: FetchRequest<Todo>
  var todos: FetchedResults<Todo> {
    todosFetchRequest.wrappedValue
  }
  
  let sortTypes = [
    (name: Todo.SortType.createdAt.toString(), descriptors: [SortDescriptor(\Todo.createdAt, order: .forward)]),
    (name: Todo.SortType.isComplete.toString(), descriptors: [SortDescriptor(\Todo.isComplete, order: .forward)]),
    (name: Todo.SortType.name.toString(), descriptors: [SortDescriptor(\Todo.title, order: .forward)])
  ]
  
  init(todoList: TodoList) {
    self.todoList = todoList
    todosFetchRequest = Todo.todos(in: todoList)
  }
  
  var categories: Array<Category> {
    // .todos is optional and thus use compactMap to only get non-nil results
    let categoriesSet = todoList.todos
      .compactMap({$0.categories})
      .reduce(Set<Category>(), { result, categories in
        var result = result
        result.formUnion(categories)
        return result
      })
    
    return Array(categoriesSet)
  }
  
  var body: some View {
    listOfTodos
      .onChange(of: activeSortIndex) { _ in
        todos.sortDescriptors = sortTypes[activeSortIndex].descriptors
      }
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Menu {
            Picker(selection: $activeSortIndex) {
              ForEach(0..<sortTypes.count, id: \.self) { index in
                let sortType = sortTypes[index]
                Text(sortType.name)
              }
            } label: {}
          } label: {
            Image(systemName: "line.3.horizontal.decrease.circle.fill")
          }
          
          Button(action: { isCategoriesModalPresented.toggle() }) {
            Text("Categories")
          }
          .sheet(isPresented: $isCategoriesModalPresented) {
            CategoryListModal(categories: categories)
          }
        }
      }
  }
  
  var listOfTodos: some View {
    List {
      Section {
        ForEach(todos) { todo in
          NavigationLink(destination: TodoDetailScreen(todo: todo)) {
            HStack {
              Image(systemName: todo.isComplete ? "checkmark.circle" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(todo.isComplete ? .green : .red)
                .onTapGesture {
                  toggleIsCompleteFor(todo: todo)
                }
              
              Text("\(todo.title)")
            }
          }
        }
        .onDelete(perform: delete)
      } header: {
        let sortType = Todo.SortType(rawValue: activeSortIndex) ?? .createdAt
        Text(sortType.title)
      } footer: {
        Text("\(todos.count) todos")
          .alignToRight
      }
    }
  }
}

extension AllTodoView {
  private func toggleIsCompleteFor(todo: Todo) {
    todo.isComplete.toggle()
    todo.save(using: viewContext)
  }
  
  private func delete(at offsets: IndexSet) {
    guard let index = offsets.first
    else {
      print("❌ -> Failed to get first index of Todos.")
      return
    }
    
    todos[index].delete(using: viewContext)
  }
}

//struct AllTodoView_Previews: PreviewProvider {
//  @FetchRequest(fetchRequest: Todo.all) private static var allTodos
//
//  static var previews: some View {
//    AllTodoView(todos: allTodos, sortIndex: Todo.SortType.default.rawValue)
//      .previewLayout(.sizeThatFits)
//  }
//}
