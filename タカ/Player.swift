import SwiftUI
import AVKit

// just use to enforce file url, and pass avplayer along to not get 1 entire instance
struct Player: View {
  @Binding var documentURL: URL!
    
  var body: some View {
    if (documentURL != nil) {
      return AnyView(PlayerView(player: AVPlayer(url: URL(string: documentURL.absoluteString)!), documentURL: $documentURL).ignoresSafeArea())
    } else {
      return AnyView(Text(""))
    }
  }
}
