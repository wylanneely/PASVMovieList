//
//  DetailViewController.swift
//  MovieList
//
//  Created by Wylan L Neely on 1/21/25.
//

import UIKit

class DetailViewController: UIViewController {

    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movie?.title
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var movieTitle: UILabel!
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
