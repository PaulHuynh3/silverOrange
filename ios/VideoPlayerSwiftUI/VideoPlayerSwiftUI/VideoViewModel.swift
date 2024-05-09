//
//  ViewViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Paul Huynh on 2024-05-08.
//

import Foundation

class VideoViewModel: ObservableObject {
    
    @Published var results: [VideoFeed] = []
    
    init() {
        Task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        do {
            guard let url = URL(string: "http://localhost:4000/videos") else {
                return
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let res = try JSONDecoder().decode([VideoFeed].self, from: data)
            
            await MainActor.run {
                self.results = res
            }
        } catch {
            print("failred to reach endpoint \(error)")
        }
    }
}

struct VideoFeed: Decodable {
    let id: String
    let title: String
    let hlsURL: String
    let fullURL: String
    let description: String
    let author: VideoAuthor
}

struct VideoAuthor: Decodable {
    let id: String
    let name: String
}
