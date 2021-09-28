//
//  TableViewCell.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 25/09/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    private var movieCollection: MoviesCollection?
    private var delegate: MovieCollectionViewCellDelegate?

    @IBOutlet weak var cvMovies: UICollectionView!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionViews()
    }
    
    @IBAction func showMore(_ sender: UIButton) {
        print("Present show more for \(movieCollection?.title ?? "")")
    }
    
    fileprivate func setupCollectionViews(){
        cvMovies.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 240)
        cvMovies.setCollectionViewLayout(layout, animated: true)
        cvMovies.register(UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil),
                          forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    func setMovies(movieCollection: MoviesCollection){
        self.movieCollection = movieCollection
        lbTitle.text = movieCollection.title
        cvMovies.reloadData()
    }
    
    func setDelegate(_ delegate: MovieCollectionViewCellDelegate){
        self.delegate = delegate
    }
}

extension TableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return movieCollection?.movies.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvMovies.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                for: indexPath) as? MovieCollectionViewCell
        cell?.setDelegate(delegate: self.delegate)
        if let movieCollection = movieCollection{
            cell?.set(movie: movieCollection.movies[indexPath.item])
        }
        return cell ?? UICollectionViewCell(frame: .zero)
    }
}
