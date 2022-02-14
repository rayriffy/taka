import Foundation
import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct DocumentPicker: UIViewControllerRepresentable {
  @Binding var filePath: URL!
    
  func makeCoordinator() -> DocumentPicker.Coordinator {
    return DocumentPicker.Coordinator(parent1: self)
  }
    
  func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
    let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.mpeg4Movie], asCopy: true)
    picker.allowsMultipleSelection = false
    picker.delegate = context.coordinator
    return picker
  }
    
  func updateUIViewController(_ uiViewController: DocumentPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<DocumentPicker>) {
  }
    
  class Coordinator: NSObject, UIDocumentPickerDelegate {
        
    var parent: DocumentPicker
        
    init(parent1: DocumentPicker){
      parent = parent1
    }
        
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
      parent.filePath = urls[0]
    }
  }
}
