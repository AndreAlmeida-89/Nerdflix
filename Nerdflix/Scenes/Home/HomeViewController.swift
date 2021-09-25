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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvents()
        setupNavigation()
        setupTableView()
        viewModel.getPopularMovies()
    }
    
    fileprivate func setupTableView(){
        tvHome.register(UINib(nibName: TableViewCell.identifier,
                              bundle: nil),
                        forCellReuseIdentifier: TableViewCell.identifier)
        tvHome.delegate = self
        tvHome.dataSource = self
    }
    
    fileprivate func setupNavigation(){
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    fileprivate func bindEvents(){
        viewModel.updateLayout = { [weak self] in
            self?.tvHome.reloadData()
        }
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
        cell?.setMovies(movies: viewModel.moviesLists[indexPath.row])
        return cell ?? UITableViewCell(frame: .zero)
    }
}
