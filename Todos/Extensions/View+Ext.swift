//
//  View+Ext.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-12.
//

import SwiftUI


extension View {
  var previewInAllColorSchemes: some View {
    Group {
      ForEach(ColorScheme.allCases, id: \.hashValue, content: preferredColorScheme)
    }
  }
  
  var alignToCenter: some View {
    HStack {
      Spacer()
      self
      Spacer()
    }
  }
  
  var alignToRight: some View {
    HStack {
      Spacer()
      self
    }
  }
  
  var backgroudLinearGradient: some View {
    ZStack {
      LinearGradient(colors: [.purple, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
      
      self
    }
  }
}
