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
    
    private(set) var moviesLists: [[Movie]] = []
    
    func getPopularMovies() {
        AF.request(Endpoint.Top250Movies.ulrString(), method: .get).responseJSON { response in
            guard let data = response.data else { return }
            
          
            let decoder = JSONDecoder()
            do {
                let moviesResponse = try decoder.decode(MovieList.self, from: data)
                self.moviesLists.append(moviesResponse.items)
                print(self.moviesLists)
                self.updateLayout?()
            } catch {
                debugPrint("Json parsin error: ", error)
            }
        }
    }
    
}

