//
//  ViewController.swift
//  MovieList
//
//  Created by Wylan L Neely on 1/13/25.
//

import UIKit

class ViewController: UIViewController {

    
    var movies:  [Movie]? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieController.getNowPlayingMovies { movies in
            self.movies = movies
        }
        
    }


}

