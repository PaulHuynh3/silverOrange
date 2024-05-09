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
            ScrollView {
                Text("Video player")
                VideoPlayer(player: AVPlayer(url: URL(string: "https://www.youtube.com/watch?v=K51qem9z2Hc")!))
                    .frame(height: 400)
                
                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Title")
                            Text("Author")
                        }
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("asfasfsafaa asfsafsaf afsafasfasf asfafsafsa qwfaasfsafa fsasafasfasf asfasfasfsafasf asfasfsaf asfsafsaf asfasfsafa fasfsafa fasfsaf asfas fasfasfasf fas")
                    }
                }.padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5 ))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
