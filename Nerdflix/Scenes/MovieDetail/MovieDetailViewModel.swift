//
//  MovieDetailViewModel.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 26/09/21.
//

import Foundation
import Alamofire

class MovieDetailViewModel {
    
    var updateUI: (()->Void)?
    private(set) var movie: Movie?
    
    func getMovieDetail(with id: String){
        getMovie(with: id)
    }
    
    private func getMovie(with id: String) {
        AF.request(Endpoint.MovieDetail.ulrString(id: id),
                   method: .get).responseJSON { response in
            guard let data = response.data else { return }
            let decoder = JSONDecoder()
            do {
                let movie = try decoder.decode(Movie.self, from: data)
                self.movie = movie
                self.updateUI?()
            } catch {
                debugPrint("Json parsing error: ", error)
            }
        }
    }
    
}
