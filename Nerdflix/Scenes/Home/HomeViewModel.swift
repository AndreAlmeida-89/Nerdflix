//
//  HomeViewModel.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 24/09/21.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    var updateTableView: (()->Void)?
    var updateHeader: (()->Void)?
    
    private(set) var moviesLists: [MoviesCollection] = []
    private(set) var mainMovie: Movie?
    private let mainMovieID = "tt1375666"
    
    func getMovies() {
        getMovies(at: .ComingSoon)
        getMovies(at: .InTheaters)
        getMovies(at: .MostPopularMovies)
        getMovies(at: .Top250Movies)
    }
    
    func getMainMovie() {
        getMovie(with: mainMovieID)
    }
    
    private func getMovies(at endpoint: Endpoint) {
        AF.request(endpoint.ulrString(),
                   method: .get).responseJSON { response in
            guard let data = response.data else { return }
            let decoder = JSONDecoder()
            do {
                let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
                let movieCollection = MoviesCollection(movies: moviesResponse.items,
                                                      title: endpoint.rawValue)
                self.moviesLists.append(movieCollection)
                self.updateTableView?()
            } catch {
                debugPrint("Json parsing error: ", error)
            }
        }
    }

    private func getMovie(with id: String) {
        AF.request(Endpoint.MovieDetail.ulrString(id: id),
                   method: .get).responseJSON { response in
            guard let data = response.data else { return }
            let decoder = JSONDecoder()
            do {
                let movie = try decoder.decode(Movie.self, from: data)
                self.mainMovie = movie
                self.updateHeader?()
            } catch {
                debugPrint("Json parsing error: ", error)
            }
        }
    }
    
}


