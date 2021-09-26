//
//  HomeViewModel.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 24/09/21.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    var updateLayout: (()->Void)?
    
    private(set) var moviesLists: [MoviesCollection] = []
    
    func getMovies() {
        getMovies(at: .ComingSoon)
        getMovies(at: .InTheaters)
        getMovies(at: .MostPopularMovies)
        getMovies(at: .Top250Movies)
    }
    
    private func getMovies(at endpoint: Endpoint) {
        AF.request(endpoint.ulrString(), method: .get).responseJSON { response in
            guard let data = response.data else { return }
            let decoder = JSONDecoder()
            do {
                let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
                let movieCollection = MoviesCollection(movies: moviesResponse.items,
                                                      title: endpoint.rawValue)
                self.moviesLists.append(movieCollection)
                self.updateLayout?()
            } catch {
                debugPrint("Json parsin error: ", error)
            }
        }
    }
    
}

