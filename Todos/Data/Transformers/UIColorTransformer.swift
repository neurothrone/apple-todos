//
//  UIColorTransformer.swift
//  Todos
//
//  Created by Zaid Neurothrone on 2022-09-14.
//

import UIKit

final class UIColorTransformer: ValueTransformer {
  override func transformedValue(_ value: Any?) -> Any? {
    guard let color = value as? UIColor
    else {
      return nil
    }
    
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
      return data
    } catch {
      print("❌ -> Failed to transform UIColor into Data: \(error.localizedDescription)")
      return nil
    }
        
  }
  
  override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard let data = value as? Data
    else {
      return nil
    }
    
    do {
      let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
      return color
    } catch {
      print("❌ -> Failed to reverse transform Data into UIColor: \(error.localizedDescription)")
      return nil
    }
  }
}
