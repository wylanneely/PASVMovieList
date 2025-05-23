//
//  MovieController.swift
//  MovieList
//
//  Created by Wylan L Neely on 1/13/25.
//

import Foundation
import UIKit

class MovieController {
    
   private static let bearer = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOWU1ZDVlMDI3NmZiMmNjNDBjMjU4NTNhMzIwYWNhOCIsIm5iZiI6MTczNjgxNjEyNC41NDgsInN1YiI6IjY3ODViNWZjZGI0ZmUwMjJhZDRlNzRhNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Rz054mDugDKQnKvmHdbnoH8-hyLeVr0PNosV-d9Ix9M"
    
    //NOTE: In future add error handling
    static func getNowPlayingMovies(pageNumber: Int = 1, completion: @escaping ([Movie]?) -> Void){
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
        
        NetworkController.performRequest(for: url,
                                         httpMethod: .get,
                                         urlParameters: ["language":"en-US","page":"\(pageNumber)"],
                                         headers: ["accept":"application/json", "Authorization": bearer],
                                         body: nil) { data, error in
            guard let data = data,
                  let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                  let resultsDictionary = jsonDictionary["results"] as? [[String:Any]]  else {
                return
            }
            var movies = [Movie]()
            for movieJSON in resultsDictionary {
                if let movie = Movie(jsonData: movieJSON) {
                    movies.append(movie)
                }
            }
            completion(movies)
            
        }
        
    }
    
    
    static func returnMovieImage(path: String, completion: @escaping (UIImage?) -> Void) {
        let imageBaseString = "https://image.tmdb.org/t/p/w500/"
        guard let baseURL = URL(string: imageBaseString) else {
            completion(nil)
            return
        }
        let fullURL = baseURL.appendingPathComponent(path)
        
        NetworkController.downloadImage(from: fullURL) { image in
            completion(image)
        }
    }
    
    
    
}
