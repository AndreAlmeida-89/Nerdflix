//
//  MovieDetailViewController.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 26/09/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private let movieId: String
    private var viewModel = MovieDetailViewModel()
    @IBOutlet weak var lbPlot: UILabel!
    @IBOutlet weak var headerView: Header!
    @IBOutlet weak var cvActors: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalhes do Filme"
        setupCollectionView()
        bindEvents()
        viewModel.getMovieDetail(with: movieId)
    }
    
    init(movieId: String){
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCollectionView(){
        cvActors.register(UINib(nibName: ActorCollectionViewCell.identifier,
                                bundle: nil),
                          forCellWithReuseIdentifier: ActorCollectionViewCell.identifier)
        cvActors.dataSource = self
        cvActors.delegate = self
    }
    
    fileprivate func bindEvents(){
        viewModel.updateUI = { [weak self] in
            self?.setupUI()
        }
    }
    
    private func setupUI(){
        guard let movie = viewModel.movie else {return}
        headerView.set(movie: movie)
        lbPlot.text = movie.plotLocal
        cvActors.reloadData()
    }
   
}
extension MovieDetailViewController: UICollectionViewDelegate{
    
}

extension MovieDetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movie?.actorList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvActors.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.identifier, for: indexPath) as? ActorCollectionViewCell
        
        if let actor = viewModel.movie?.actorList?[indexPath.item]{
            cell?.setupUI(with: actor)
        }
        
        return cell ?? UICollectionViewCell(frame: .zero)
    }
    
    
}
