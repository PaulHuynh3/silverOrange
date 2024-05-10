//
//  PlayerControlButtons.swift
//  VideoPlayerSwiftUI
//
//  Created by Paul Huynh on 2024-05-10.
//

import SwiftUI
import AVKit

@available(iOS 15.0, *)
struct PlayerControlButtons: View {
        
    @Binding var isPlaying: Bool
    @Binding var timer: Timer?
    @Binding var showPlayerControlButtons: Bool
    @Binding var avPlayer: AVPlayer
    @Binding var currentIndex: Int
    var scrollViewProxy: ScrollViewProxy
    var results: [VideoFeed]
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    if currentIndex > 0 {
                        currentIndex -= 1
                        scrollViewProxy.scrollTo(currentIndex)
                        avPlayer.pause()
                        let url = URL(string: results[currentIndex].fullURL)!
                        avPlayer.replaceCurrentItem(with: AVPlayerItem(url: url))
                    }
                } label: {
                    Image(uiImage: UIImage(named: "previous")!)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.white)
                }
                Button {
                    if isPlaying {
                        isPlaying = false
                        avPlayer.pause()
                        timer?.invalidate()
                    }
                    else {
                        isPlaying = true
                        avPlayer.play()
                        startTimer(timeInterval: 5)
                    }
                } label: {
                    Image(uiImage: isPlaying ? UIImage(named: "pause")! : UIImage(named: "play")!)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.white)
                    
                }
                Button {
                    if currentIndex < results.count - 1 {
                        currentIndex = currentIndex + 1
                        scrollViewProxy.scrollTo(currentIndex)
                        avPlayer.pause()
                        let url = URL(string: results[currentIndex].fullURL)!
                        avPlayer.replaceCurrentItem(with: AVPlayerItem(url: url))
                    }
                } label: {
                    Image("next")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.white)
                    
                }
                Spacer()
            }
            Spacer()
        }
    }
    
    private func startTimer(timeInterval: Double) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { timer in
            withAnimation {
                showPlayerControlButtons = false
            }
        }
    }
}
