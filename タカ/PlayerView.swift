import SwiftUI
import AVKit

struct PlayerView: View {
  let player: AVPlayer
  @Binding var documentURL: URL!
  
  @State var avScale: CGFloat! = 1.0
  
  var body: some View {
    return ZStack {
      Rectangle()
        .fill(.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.frame(width: .infinity, height: .infinity, alignment: .center)
      AVPlayerControllerRepresented(player: player).scaleEffect(avScale)
      PlayerControl(player: player, documentURL: $documentURL, avScale: $avScale)
    }
  }
}

struct AVPlayerControllerRepresented : UIViewControllerRepresentable {
  var player : AVPlayer

  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let controller = AVPlayerViewController()
    controller.player = player
    controller.showsPlaybackControls = false
        
    return controller
  }
    
  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
