//
//  ImagePicker.swift
//  TodoTrackerWithCoreData
//
//  Created by Zaid Neurothrone on 2022-09-14.
//

import PhotosUI
import SwiftUI

// New approach
struct ImagePicker: UIViewControllerRepresentable {
  @Binding var image: UIImage?
  
  func makeUIViewController(context: Context) -> PHPickerViewController {
    var config = PHPickerConfiguration()
    config.filter = .images
    
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    
    return picker
  }
  
  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, PHPickerViewControllerDelegate {
    let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      picker.dismiss(animated: true)
      
      guard let provider = results.first?.itemProvider else { return }
      
      if provider.canLoadObject(ofClass: UIImage.self) {
        provider.loadObject(ofClass: UIImage.self) { image, _ in
          self.parent.image = image as? UIImage
        }
      }
    }
  }
}

// Old approach
//struct ImagePicker: UIViewControllerRepresentable {
//  @Environment(\.dismiss) private var dismiss
//  @Binding var image: UIImage?
//
//  var sourceType: UIImagePickerController.SourceType = .photoLibrary
//
//  func makeUIViewController(
//    context: UIViewControllerRepresentableContext<ImagePicker>
//  ) -> UIImagePickerController {
//    let imagePicker = UIImagePickerController()
//
//    imagePicker.allowsEditing = false
//    imagePicker.sourceType = sourceType
//    imagePicker.delegate = context.coordinator
//
//    return imagePicker
//  }
//
//  func updateUIViewController(
//    _ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
//
//  func makeCoordinator() -> Coordinator {
//    Coordinator(self)
//  }
//
//  final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    var parent: ImagePicker
//
//    init(_ parent: ImagePicker) {
//      self.parent = parent
//    }
//
//    func imagePickerController(
//      _ picker: UIImagePickerController,
//      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
//    ) {
//      if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//        parent.image = image
//      }
//
//      parent.dismiss()
//    }
//  }
//}
