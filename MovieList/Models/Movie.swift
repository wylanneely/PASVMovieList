//
//  Movie.swift
//  MovieList
//
//  Created by Wylan L Neely on 1/13/25.
//

import Foundation

struct Movie {
    
    let adult: Bool
    let id: Int
    let originalLanguage: String
    let overview: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let posterPath: String
    let backdropPath: String
    
    init?(jsonData: [String: Any]){
        self.adult = jsonData["adult"] as? Bool ?? false
        self.id = jsonData["id"] as? Int ?? 0
        self.originalLanguage = jsonData["original_language"] as? String ?? ""
        self.overview = jsonData["overview"] as? String ?? ""
        self.releaseDate = jsonData["release_date"] as? String ?? ""
        self.title = jsonData["title"] as? String ?? ""
        self.voteAverage = jsonData["vote_average"] as? Double ?? 0
        
        self.backdropPath = jsonData["backdrop_path"] as? String ?? ""
        self.posterPath = jsonData["poster_path"] as? String ?? ""
        
        
        
    }
    
}

