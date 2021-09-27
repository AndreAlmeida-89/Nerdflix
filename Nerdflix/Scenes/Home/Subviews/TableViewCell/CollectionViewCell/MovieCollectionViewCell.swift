//
//  MovieCollectionViewCell.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 24/09/21.
//

import UIKit
import Kingfisher

protocol MovieCollectionViewCellDelegate: AnyObject{
    func showMovieDetail(with id: String)
    func showSeeMore(with: MoviesCollection)
}

class MovieCollectionViewCell: UICollectionViewCell {
    private var delegate: MovieCollectionViewCellDelegate?
    static let identifier = "MovieCollectionViewCell"
    private var movie: Movie?
    
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(movie: Movie){
        self.movie = movie
        setupUI()
    }
    
    func setDelegate(delegate: MovieCollectionViewCellDelegate?){
        self.delegate = delegate
    }
    
    private func setupUI(){
        lbMovieTitle.text = movie?.title
        ivMovie.kf.setImage(with: movie?.image)
        ivMovie.layer.cornerRadius = 5
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let movie = movie else { return }
        print("filme escolhido: \(movie.title)")
        delegate?.showMovieDetail(with: movie.id)
    }
}
