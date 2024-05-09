//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @ObservedObject var viewModel = VideoViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.results, id: \.self) { res in
                        VStack(alignment: .leading) {
                            VideoPlayer(player: AVPlayer(url: URL(string: "https://www.youtube.com/watch?v=K51qem9z2Hc")!))
                                .frame(width: UIScreen.main.bounds.size.width, height: 200)
                                
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
