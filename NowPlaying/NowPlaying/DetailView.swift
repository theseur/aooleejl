//
//  DetailView.swift
//  NowPlaying
//
//  Created by Kovács Márk on 14/11/2023.
//

import SwiftUI

struct DetailView: View {
    var m: Result
    var body: some View {
        Form {
            Section {
                Text(m.title ?? "")
                    .font(.title)
            }
            Section {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(m.posterPath ?? "")")) { phase in
                    phase.image?
                        .resizable()
                        .scaledToFit()
                }
            }
            Section {
                Text(m.overview ?? "")
            } header: {
                Text("Overview")
            }
        }
       
    }
}
