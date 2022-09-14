//
//  AddTodoModal.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-12.
//

import SwiftUI

struct AddTodoModal: View {
  
  // MARK: - Environment
  @Environment(\.dismiss) private var dismiss
  @Environment(\.managedObjectContext) private var viewContext
  
  // MARK: - State
  @State private var title = ""
  @State private var notes = ""
  @State private var priority: Priority = .medium
  @State private var categories = ""
  @State private var hasDeadline = false
  @State private var deadlineAt = Date()
  
  @State private var isImagePickerPresented = false
  @State private var selectedImage: UIImage?
  
  let todoList: TodoList
  
  var body: some View {
    Form {
      Section {
        TextField("Title", text: $title)
          .autocorrectionDisabled(true)
          .textInputAutocapitalization(.never)
        TextField("Notes", text: $notes)
          .autocorrectionDisabled(true)
          .textInputAutocapitalization(.never)
        
        Picker("Priority", selection: $priority) {
          ForEach(Priority.allCases) {
            Text($0.toString())
          }
        }
        .pickerStyle(.segmented)
      }
      
      Section {
        TextField("Categories", text: $categories)
          .autocorrectionDisabled(true)
          .textInputAutocapitalization(.never)
      } footer: {
        Text("If adding multiple categories, separate them by comma. E.g. \"groceries,work,chores\".")
      }
      
      Section {
        Toggle("Has deadline?", isOn: $hasDeadline)
        
        if hasDeadline {
          DatePicker(selection: $deadlineAt, displayedComponents: .date) {
            Text("Deadline")
          }
        }
      }
      
      Section {
        if let image = selectedImage {
          Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
        } else {
          Button("Pick Image") {
            isImagePickerPresented.toggle()
          }
        }
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
    .navigationTitle("Create a Todo")
    .navigationBarTitleDisplayMode(.inline)
    .sheet(isPresented: $isImagePickerPresented) {
      ImagePicker(image: $selectedImage)
    }
  }
}

extension AddTodoModal {
  private func save() {
    let categoriesSet = Set(categories.split(separator: ",").map {
      Category.fetchOrCreateWith(title: String($0), using: viewContext)
    })
    
    Todo.createWith(
      title: title,
      notes: notes,
      priority: priority,
      deadlineAt: hasDeadline ? deadlineAt : nil,
      categories: categoriesSet,
      image: selectedImage,
      in: todoList,
      using: viewContext
    )
    
    dismiss()
  }
}

struct AddTodoModal_Previews: PreviewProvider {
  static var previews: some View {
    let context = CoreDataManager.preview.viewContext
    let todoList = TodoList(context: context)
    todoList.title = "Preview List"
    CoreDataManager.save(using: context)
    
    return NavigationView {
      AddTodoModal(todoList: todoList)
        .environment(\.managedObjectContext, CoreDataManager.preview.viewContext)
    }
  }
}
