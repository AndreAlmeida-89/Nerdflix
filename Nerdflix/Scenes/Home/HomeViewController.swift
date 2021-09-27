//
//  HomeViewController.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 24/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    
 
    let viewModel = HomeViewModel()
    
    @IBOutlet weak var headerView: Header!
    @IBOutlet weak var constTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tvHome: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvents()
        setupNavigation()
        setupTableView()
        setupHeader()
        viewModel.getMainMovie()
        viewModel.getMovies()
        
    }
    
    
    fileprivate func setupTableView(){
        tvHome.register(UINib(nibName: TableViewCell.identifier,
                              bundle: nil),
                        forCellReuseIdentifier: TableViewCell.identifier)
        tvHome.delegate = self
        tvHome.dataSource = self
    }
    
    fileprivate func setupNavigation(){
        title = "Nerdflix"
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.isTranslucent = false
    }
    
    fileprivate func setupHeader(){
        guard let movie = viewModel.mainMovie else {return}
        headerView.set(movie: movie)
    }
    
    fileprivate func bindEvents(){
        viewModel.updateTableView = { [weak self] in
            self?.tvHome.reloadData()
            self?.adjustTableViewHeight()
        }
        
        viewModel.updateHeader = { [weak self] in
            self?.setupHeader()
        }
    }
    
    fileprivate func adjustTableViewHeight(){
        let height = tvHome.contentSize.height
        constTableViewHeight.constant = height
    }
    
}

extension HomeViewController: UITableViewDelegate{
    
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.moviesLists.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvHome.dequeueReusableCell(withIdentifier: TableViewCell.identifier,
                                              for: indexPath) as? TableViewCell
        cell?.setDelegate(self)
        cell?.setMovies(movieCollection: viewModel.moviesLists[indexPath.row])
        return cell ?? UITableViewCell(frame: .zero)
    }
}


extension HomeViewController: MovieCollectionViewCellDelegate{
    
    func showMovieDetail(with id: String) {
        let movieDetailViewController = MovieDetailViewController(movieId: id)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func showSeeMore(with: MoviesCollection){
        
    }

}
