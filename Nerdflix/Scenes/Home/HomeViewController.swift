//
//  HomeViewController.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 24/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tvHome: UITableView!
    let viewModel = HomeViewModel()
    
    @IBOutlet weak var constTableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvents()
        setupNavigation()
        setupTableView()
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
    }
    
    fileprivate func bindEvents(){
        viewModel.updateLayout = { [weak self] in
            self?.tvHome.reloadData()
            self?.adjustTableViewHeight()
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
        cell?.setMovies(movieCollection: viewModel.moviesLists[indexPath.row])
        return cell ?? UITableViewCell(frame: .zero)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if let url = URL(string: "https://imdb-api.com/images/original/MV5BMTUyNTkxODIxN15BMl5BanBnXkFtZTgwOTU2MDAwMTE@._V1_Ratio0.7273_AL_.jpg"){
//            
//            let movie = Movie(id: "movie 2913913",
//                             title: "Inception",
//                             image: url)
//            let view = Header()
//            view.set(movie: movie)
//            return view
//        }
//        
//        return UIView(frame: .zero)
//        
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 400
//    }
}
