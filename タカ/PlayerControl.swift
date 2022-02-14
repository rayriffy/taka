import SwiftUI
import AVKit

struct PlayerControl: View {
  let player : AVPlayer
  @Binding var documentURL: URL!
  @Binding var avScale: CGFloat!

  @State var isPlaying = false
  @State var playRate: Float = 1.0
  @State var navigated = false
  @State var hiddenControl = false

  func scale(isSmaller: Bool) {
    let scaleRate = 0.10
    let targetScale = isSmaller ? avScale - scaleRate : avScale + scaleRate

    // if (Int(targetScale * 100) <= 0 || Int(targetScale * 100) > 200) {
    if (Int(targetScale * 100) <= 0) {
      return
    } else {
      avScale = targetScale
    }
  }

  func changeSpeed(isSlower: Bool) {
    let targetRate = isSlower ? playRate - 0.25 : playRate + 0.25

    // ignore change if goes out of bound
    if (targetRate <= 0 || targetRate > 2) {
      return
    } else {
      playRate = targetRate
      isPlaying = true
      player.playImmediately(atRate: targetRate)
    }
  }

  func warp(isBackward: Bool) {
    guard let duration  = player.currentItem?.duration else {
      return
    }

    let warpAmount: Float = 5 * playRate
    let currentTime = CMTimeGetSeconds(player.currentTime())

    var endPoint = isBackward ? currentTime - Float64(warpAmount) : currentTime + Float64(warpAmount)

    // if seek backward and goes to negative
    if (endPoint < 0) {
      endPoint = 0
    }

    if (isBackward) {
      player.seek(to: CMTimeMake(value: Int64(endPoint * 1000 as Float64), timescale: 1000), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    } else {
      if endPoint < (CMTimeGetSeconds(duration) - Float64(warpAmount)) {
        player.seek(to: CMTimeMake(value: Int64(endPoint * 1000 as Float64), timescale: 1000), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
      }
    }
  }

  var body: some View {
    HStack(alignment: .top) {
      VStack (alignment: .leading, spacing: 0) {
        HStack(spacing: 1) {
          Button(action: {
            documentURL = nil
          }) {
            Image(systemName: "multiply.circle.fill").foregroundColor(.white).dynamicTypeSize(.accessibility1).padding(1)
          }
          Button(action: {
            hiddenControl.toggle()
          }) {
            Image(systemName: hiddenControl == false ? "eye.circle.fill" : "eye.slash.circle.fill").foregroundColor(.white).dynamicTypeSize(.accessibility1).padding(1)
          }
        }
        if (!hiddenControl) {
          VStack (alignment: .center, spacing: 0) {
            Text("").padding([.bottom], 6)
            Button(action: {
              changeSpeed(isSlower: false)
            }) {
              Image(systemName: "arrowtriangle.up.fill").foregroundColor(.white).dynamicTypeSize(.accessibility1).padding(1)
            }
            HStack(spacing: 0) {
              Text("x").foregroundColor(.white)
              Text(String(playRate)).fontWeight(.bold).foregroundColor(.white)
            }
            Button(action: {
              changeSpeed(isSlower: true)
            }) {
              Image(systemName: "arrowtriangle.down.fill").foregroundColor(.white).dynamicTypeSize(.accessibility1).padding(1)
            }
            Spacer()
            Button(action: {
              scale(isSmaller: false)
            }) {
              Image(systemName: "arrowtriangle.up.fill").foregroundColor(.white).dynamicTypeSize(.accessibility1).padding(1)
            }
            HStack(spacing: 0) {
              Text(String(Int(avScale * 100))).fontWeight(.bold).foregroundColor(.white)
              Text("%").foregroundColor(.white)
            }
            Button(action: {
              scale(isSmaller: true)
            }) {
              Image(systemName: "arrowtriangle.down.fill").foregroundColor(.white).dynamicTypeSize(.accessibility1).padding(1)
            }
          }
        }
      }
      Spacer()
      if (!hiddenControl) {
        VStack {
          Button(action: {
            if (isPlaying) {
              player.pause()
              isPlaying = false
            } else {
              player.playImmediately(atRate: playRate)
              isPlaying = true
            }
          }) {
            Image(systemName: !isPlaying ? "play.fill" : "pause.fill").foregroundColor(.white).dynamicTypeSize(.accessibility2).padding(1)
          }
          Text("").padding([.bottom], 6)
          Button (action: {
            warp(isBackward: false)
          }) {
            Image(systemName: "forward").foregroundColor(.white).dynamicTypeSize(.accessibility1).padding(1)
          }
          Button (action: {
            warp(isBackward: true)
          }) {
            Image(systemName: "backward").foregroundColor(.white).dynamicTypeSize(.accessibility1).padding(1)
          }
          Text("").padding([.bottom], 6)
          Button (action: {
            player.seek(to: CMTimeMake(value: 0, timescale: 1000), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
          }) {
            Image(systemName: "backward.end").foregroundColor(.white).dynamicTypeSize(.accessibility1).padding(1)
          }
        }
      }
    }
    .padding()
    .frame(
      minWidth: 0,
      maxWidth: .infinity,
      minHeight: 0,
      maxHeight: .infinity,
      alignment: .topLeading
    )
  }
}
