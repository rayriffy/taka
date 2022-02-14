import SwiftUI

struct ContentView: View {
  @State private var documentPath: URL?
  @State private var isDocumentPickerActive = false

  var body: some View {
    if (documentPath != nil) {
      return AnyView(Player(documentURL: $documentPath))
    }

    return AnyView(VStack {
      VStack {
        Text("Taka").fontWeight(.bold).font(.title)
        Text("Play video stored on your device, and practice your rhythm game without any disturbance from video controls".localized).font(.subheadline).multilineTextAlignment(.center).padding([.top], 0.01)
      }.padding()

      Button("Pick file".localized){
        isDocumentPickerActive = true
      }
      .padding(12)
      .foregroundColor(Color.white)
      .background(Color.blue)
      .cornerRadius(6)
    }.sheet(isPresented: self.$isDocumentPickerActive) {
      DocumentPicker(filePath: $documentPath)
    })
  }
}
