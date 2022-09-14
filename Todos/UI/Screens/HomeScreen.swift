//
//  HomeScreen.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-12.
//

import SwiftUI

struct HomeScreen: View {
  
  @FetchRequest(fetchRequest: TodoList.all) private var todoLists
  @State private var isCreateModalPresented = false
  
  var body: some View {
    NavigationView {
      AllTodoListView(todoLists: todoLists)
        .navigationTitle("Todo Lists")
        .sheet(isPresented: $isCreateModalPresented) {
          AddTodoListModal()
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
}

extension HomeScreen {
  private func delete(at offsets: IndexSet) {
    guard let index = offsets.first
    else {
      print("❌ -> Failed to get first index")
      return
    }
    
    CoreDataManager.deleteList(todoLists[index])
  }
}

struct HomeScreen_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen()
      .environment(\.managedObjectContext, CoreDataManager.preview.viewContext)
    //      .previewInAllColorSchemes
  }
}
