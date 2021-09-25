//
//  TableViewCell.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 25/09/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    private var movies: [Movie] = [] {
        didSet{
            cvMovies.reloadData()
        }
    }
    
    @IBOutlet weak var cvMovies: UICollectionView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionViews()
    }

    fileprivate func setupCollectionViews(){
        cvMovies.dataSource = self
        cvMovies.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 260)
        cvMovies.setCollectionViewLayout(layout, animated: true)
        cvMovies.register(UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil),
                          forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    func setMovies(movies: [Movie]){
        self.movies = movies
    }
}

extension TableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvMovies.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                for: indexPath) as? MovieCollectionViewCell
        cell?.set(movie: movies[indexPath.item])
        return cell ?? UICollectionViewCell(frame: .zero)
    }
}

extension TableViewCell: UICollectionViewDelegate {
    
}
