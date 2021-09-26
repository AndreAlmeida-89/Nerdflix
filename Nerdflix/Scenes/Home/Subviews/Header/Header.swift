//
//  Header.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 26/09/21.
//

import UIKit
import Kingfisher

class Header: UIView {
    private var movie: Movie?
    
   
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(movie: Movie){
        self.movie = movie
        setupUI(movie)
    }
    
    private func setupUI(_ movie: Movie){
        lbTitle.text = movie.title
        ivPoster.kf.setImage(with: movie.image)
        ivPoster.layer.cornerRadius = 20
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let movie = movie else { return }
        print("filme escolhido: \(movie.title)")
    }
    
}
