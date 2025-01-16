//
//  MoviesTableViewCell.swift
//  MovieList
//
//  Created by Wylan L Neely on 1/13/25.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setOutlets(image:UIImage,title: String) {
        self.movieImage.image = image
        self.title.text = title
    }
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
