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
    VStack {
      Text(todo.title)
      
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

//struct TodoDetailScreen_Previews: PreviewProvider {
//  static var previews: some View {
//    TodoDetailScreen()
//  }
//}
