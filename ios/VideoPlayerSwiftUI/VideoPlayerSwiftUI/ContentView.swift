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
                                PlayerContentView(player: $player, showControls: $showControls, timer: $timer, res: res, controlButtons: controlButtons, isPlaying: isPlaying, index: index)
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
