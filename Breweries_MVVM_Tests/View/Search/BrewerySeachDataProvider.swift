//
//  BrewerySeachDataProvider.swift
//  Breweries_MVVM_Tests
//
//  Created by adam smith on 2/19/22.
//

import Foundation

protocol BrewerySearchDataProvidable {
    func fetch(from endpoint: BrewerySearchEnpoint, completion: @escaping (Result<Brewery, NetworkError>) -> Void )
}

struct BrewerySearchDataProvider: APIDataProvidable, BrewerySearchDataProvidable {
    func fetch(from endpoint: BrewerySearchEnpoint, completion: @escaping (Result<Brewery, NetworkError>) -> Void) {
        
        guard let url = endpoint.url else {
            completion(.failure(.badURL(nil)))
            return
        }
        
        perform(URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let list = try decoder.decode(Brewery.self, from: data)
                    completion(.success(list))
                } catch {
                    completion(.failure(.errorDecoding(error)))
                }
            case .failure(let error):
                completion(.failure(.requestError(error)))
            }
        }
    }
}
    
    
    enum BrewerySearchEnpoint {
        case state(String)
        case city(String)
        
        init?(index: Int, searchTerm: String) {
            switch index {
            case 0:
                self = .state(searchTerm)
            case 1:
                self = .city(searchTerm)
            default:
                return nil
            }
        }
        
        var path: String {
            switch self {
            case .state:
                return "state"
            case .city:
                return "city"
            }
        }
        
        var url: URL? {
            guard var baseURL = URL.breweryBaseURL else { return nil }
            baseURL.appendPathComponent("search")
            switch self {
            case .state(let searchTerm), .city(let searchTerm):
                baseURL.appendPathComponent(path)
                guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
                    return nil
                }
                let searchTermQueryItem = URLQueryItem(name: "query", value: searchTerm)
                components.queryItems = [searchTermQueryItem]
                return components.url
            }
        }
    }

extension URL {
    static let breweryBaseURL = URL(string: "https://api.openbrewerydb.org/breweries")
}
