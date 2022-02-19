//
//  APIDataProvidable.swift
//  Breweries_MVVM_Tests
//
//  Created by adam smith on 2/19/22.
//

import Foundation

protocol APIDataProvidable {
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

extension APIDataProvidable {
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(.requestError(error)))
            }
            // TODO: - Handle response
            guard let data = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
