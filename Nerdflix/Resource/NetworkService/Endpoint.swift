//
//  Endpoint.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 26/09/21.
//

import Foundation

enum Endpoint: String {
    case Top250Movies = "Top 250 Filmes"
    case MostPopularMovies = "Mais Populares"
    case InTheaters = "Nos cinemas"
    case ComingSoon = "Em Breve"
    case MovieDetail
    
    
    func ulrString(id: String? = nil) -> String {
        switch self {
        case .Top250Movies:
            return API.baseUrl + "/Top250Movies/" + API.token
        case .MostPopularMovies:
            return API.baseUrl + "/MostPopularMovies/" + API.token
        case .MovieDetail:
            return API.baseUrl + "/Title/" + API.token + "/\(id ?? "")"
        case .InTheaters:
            return API.baseUrl + "/InTheaters/" + API.token
        case .ComingSoon:
            return API.baseUrl + "/ComingSoon/" + API.token
        }
    }
}
