//
//  AddTodoListModal.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-13.
//

import SwiftUI

struct AddTodoListModal: View {
  
  // MARK: - Environment
  @Environment(\.dismiss) private var dismiss
  @Environment(\.managedObjectContext) private var viewContext
  
  // MARK: - State
  @State private var title = ""
  
  var body: some View {
    Form {
      Section {
        TextField("Title", text: $title)
          .autocorrectionDisabled(true)
          .textInputAutocapitalization(.never)
      }
      
      Section {
        Button {
          save()
        } label: {
          Text("Save")
            .fontWeight(.bold)
        }
        .disabled(title.isEmpty)
      }
    }
    .navigationTitle("Create a Todo List")
    .navigationBarTitleDisplayMode(.inline)
  }
}

extension AddTodoListModal {
  private func save() {
    TodoList.createWith(
      title: title,
      using: viewContext
    )
    
    dismiss()
  }
}

struct AddTodoListModal_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AddTodoListModal()
        .environment(
          \.managedObjectContext,
           CoreDataManager.preview.viewContext
        )
    }
  }
}
