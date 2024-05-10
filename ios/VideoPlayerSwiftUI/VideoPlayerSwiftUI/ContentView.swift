//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit

@available(iOS 15.0, *)
struct ContentView: View {
    @ObservedObject var viewModel = VideoViewModel()
    @State private var player = AVPlayer()
    @State private var showControls = true
    @State private var isPlaying = false
    @State private var timer: Timer?
    @State var currentIndex = 0
    
    var body: some View {
        NavigationView {
            ScrollViewReader { value in
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(zip(viewModel.results.indices, viewModel.results)), id: \.0) { index, res in
                            VStack(alignment: .leading) {
                                let controlButtons = PlayerControlButtons(
                                    isPlaying: $isPlaying,
                                    timer: $timer,
                                    showPlayerControlButtons: $showControls,
                                    avPlayer: $player, 
                                    currentIndex: $currentIndex,
                                    scrollViewProxy: value,
                                    results: viewModel.results
                                )
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
                                
                                VStack(spacing: 20) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(res.title)
                                            Text(res.author.name)
                                        }
                                        Spacer()
                                    }
                                    
                                    ScrollView {
                                        Text(res.description)
                                            .frame(width: UIScreen.main.bounds.size.width)
                                    }
                                }.padding(.leading, 5)
                                    .padding(.trailing, 5)
                            }
                        }
                    }
                }.navigationTitle("Video Player")
            }
        }
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

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
