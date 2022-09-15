//
//  TodosApp.swift
//  Shared
//
//  Created by Zaid Neurothrone on 2022-09-12.
//

import SwiftUI

@main
struct TodosApp: App {
  var body: some Scene {
    WindowGroup {
      HomeScreen()
        .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
    }
  }
}
