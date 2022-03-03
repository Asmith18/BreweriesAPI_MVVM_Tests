//
//  BrewerySearchViewModel.swift
//  Breweries_MVVM_Tests
//
//  Created by adam smith on 2/19/22.
//

import Foundation

protocol BrewerySearchViewModelDelegate: AnyObject {
    func searchResultsLoadedSuccessfully()
    func encountered(_ error: Error)
}

class BrewerySearchViewModel {
    
    var seachObjects: [BreweryResults] = []
    
    let dataProvider: BrewerySearchDataProvidable
    
    weak var delegate: BrewerySearchViewModelDelegate?
    
    init(dataProvider: BrewerySearchDataProvidable = BrewerySearchDataProvider(), delegate: BrewerySearchViewModelDelegate) {
        self.delegate = delegate
        self.dataProvider = dataProvider
    }
    
    func search(endpoint: BrewerySearchEnpoint) {
        dataProvider.fetch(from: endpoint) { [weak self] result in
            switch result {
            case .success(let list):
                self?.seachObjects = list
                self?.delegate?.searchResultsLoadedSuccessfully()
            case.failure(let error):
                print("\(error.localizedDescription)")
                self?.delegate?.encountered(error)
            }
        }
    }
}
