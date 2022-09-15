//
//  TodoDetailScreen.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-14.
//

import SwiftUI

struct TodoDetailScreen: View {
  let todo: Todo
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(todo.title)
        .font(.headline)
      
      if let notes = todo.notes {
        Text(notes)
      }
      
      Text(todo.priority.toString())
        .padding(10)
        .background(
          RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.orange)
        )
        .padding(.top, 10)
      
      if let image = todo.image {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 400, height: 400)
      }
      
      Spacer()
    }
  }
}

struct TodoDetailScreen_Previews: PreviewProvider {
  static var previews: some View {
    let context = CoreDataProvider.preview.viewContext
    let todo = Todo(context: context)
    todo.title = "Test Todo"
    todo.notes = "Welcome! There is no turning back now."
    todo.priority = .medium
    
    return TodoDetailScreen(todo: todo)
      .environment(\.managedObjectContext, context)
  }
}
