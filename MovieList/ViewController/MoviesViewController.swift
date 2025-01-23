//
//  ViewController.swift
//  MovieList
//
//  Created by Wylan L Neely on 1/13/25.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 

    
    var movies: [Movie]? {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        MovieController.getNowPlayingMovies { movies in
            self.movies = movies
        }
        
    }

    @IBOutlet weak var tableview: UITableView!
    
    func setUpTableView(){
        tableview.dataSource = self
        tableview.delegate = self
        let nib = UINib(nibName: "MoviesTableViewCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "MoviesTableViewCell")
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell else {
            return UITableViewCell()
        }

        guard let movie = movies?[indexPath.row] else {
            return cell
        }

        cell.overview.text = movie.overview
        cell.title.text = movie.title
        // Check cache for the image
        if let cachedImage = ImageCache.shared.getImage(forKey: movie.posterPath) {
            cell.movieImage.image = cachedImage
        } else {
            // Download the image if not in cache
            MovieController.returnMovieImage(path: movie.posterPath) { image in
                guard let image = image else { return } // Handle nil image 

                // Cache the image
                ImageCache.shared.setImage(image, forKey: movie.posterPath)

                // Reload the cell to refresh the image
                DispatchQueue.main.async {
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }

        return cell
    }
    
    var selectedMovie: Movie?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedMovie = movies?[indexPath.row] else {
            return
        }
        self.selectedMovie = selectedMovie
        self.performSegue(withIdentifier: "toDetailView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView",
            let destinationVC = segue.destination as? DetailViewController,
           let selectedMovie = selectedMovie {
            
            destinationVC.movie = selectedMovie
        }
    }
    
}

