//
//  ContentView.swift
//  NowPlaying
//
//  Created by Kovács Márk on 14/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = TheMovieClient()
    var body: some View {
        VStack {
            NavigationStack {
                List(model.movies.results ?? [], id: \.id) { m in
                    NavigationLink {
                        DetailView(m: m)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(m.title ?? "")
                                .bold()
                            Text(m.releaseDate ?? "")
                        }
                    }
                }
                .navigationTitle("Now playing")
            }
            .task {
                do {
                    let data = try await TheMovieClient().getNowPlayingAsync()
                    self.model.movies = data
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
