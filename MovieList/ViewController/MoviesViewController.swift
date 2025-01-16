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
        let movie = movies?[indexPath.row]
      
        
        
        return cell
    }
    

}

