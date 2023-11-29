//
//  TheMovieClient.swift
//  NowPlaying
//
//  Created by Kovács Márk on 14/11/2023.
//

import Foundation

class TheMovieClient: ObservableObject {
    @Published var movies = NowPlayingResponse()
    let apiKey = "2f5144cb4383086b3f61605f5db6fecf"
    let baseUrl = "https://api.themoviedb.org/3/"
    
    enum NetworkError: Error {
        case invalidURL
        case requestFailed(String)
    }
    
    func getNowPlayingAsync() async throws -> NowPlayingResponse {
        //url elkészítése
        guard let url = URL(string: "\(baseUrl)movie/now_playing?api_key=\(apiKey)") else {
            throw NetworkError.invalidURL
        }
        
        //kérés elküldése
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.requestFailed("Invalid response")
        }
        
        return try JSONDecoder().decode(NowPlayingResponse.self, from: data)
    }
}
