//
//  PlayerContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Paul Huynh on 2024-05-10.
//

import SwiftUI
import AVKit

@available(iOS 15.0, *)
struct PlayerContentView: View {
    @Binding var player: AVPlayer
    @Binding var showControls: Bool
    @Binding var timer: Timer?
    var res: VideoFeed
    var controlButtons: PlayerControlButtons
    var isPlaying: Bool
    var index: Int
    
    var body: some View {
        VStack {
            ZStack {
                VideoPlayer(player: player)
                    .frame(width: UIScreen.main.bounds.size.width, height: 300)
                    .id(index)
                    .onAppear() {
                        let url = URL(string: res.fullURL)!
                        player = AVPlayer(url: url)
                        player.play()
                    }
                    .onDisappear() {
                        player.pause()
                    }
                if showControls {
                    controlButtons
                }
            }
            .onTapGesture {
                withAnimation {
                    showControls.toggle()
                }
                if isPlaying {
                    startTimer()
                }
            }
        }
        
        VStack {
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text("***\(res.title)***")
                        Text("*\(res.author.name)*")
                    }
                    Spacer()
                }.padding(.bottom, 20)
                
                Text("***\(res.description)***")
                    .frame(width: UIScreen.main.bounds.size.width)
            }
        }.padding(.horizontal, 5)
    }
    
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
            withAnimation {
                showControls = false
            }
        }
    }
}
