//
//  Endpoint.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 25/09/21.
//

import Foundation


struct APIUrl{
    private static let _token = "k_itv91nl9"
    private static let _baseUrl = "https://imdb-api.com/pt/API"
    
    static var token: String {
        APIUrl._token
    }
    
    static var baseUrl: String {
        APIUrl._baseUrl
    }
}


enum Endpoint {
    case Top250Movies
    case MostPopularMovies
    case MovieDetail
    
    func ulrString(id: String? = nil) -> String {
        switch self {
        case .Top250Movies:
            return APIUrl.baseUrl + "/Top250Movies/" + APIUrl.token
        case .MostPopularMovies:
            return APIUrl.baseUrl + "/MostPopularMovies/" + APIUrl.token
        case .MovieDetail:
            return APIUrl.baseUrl + "/Title/" + APIUrl.token + "/\(id ?? "")"
        }
    }
}


//https://imdb-api.com/en/API/Top250Movies/k_3g4a43n5
//https://imdb-api.com/en/API/Top250TVs/k_3g4a43n5
//https://imdb-api.com/en/API/MostPopularMovies/k_3g4a43n5

//pegar os detalhes do filme por id
//https://imdb-api.com/en/API/FullCast/k_3g4a43n5/tt1375666
//https://imdb-api.com/en/API/Title/k_3g4a43n5/tt1375666
