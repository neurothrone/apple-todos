//
//  UIImageTransformer.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-14.
//

import SwiftUI

final class UIImageTransformer: ValueTransformer {
  override func transformedValue(_ value: Any?) -> Any? {
    guard let image = value as? UIImage
    else {
      return nil
    }
    
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
      return data
    } catch {
      print("❌ -> Failed to transform UIImage into Data: \(error.localizedDescription)")
      return nil
    }
  }
  
  override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard let data = value as? Data
    else {
      return nil
    }
    
    do {
      let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
      return image
    } catch {
      print("❌ -> Failed to reverse transform Data into UIImage: \(error.localizedDescription)")
      return nil
    }
  }
}
