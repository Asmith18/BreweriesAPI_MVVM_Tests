//
//  BreweryListTableViewController.swift
//  Breweries_MVVM_Tests
//
//  Created by adam smith on 2/19/22.
//

import UIKit

class BreweryListTableViewController: UITableViewController {

    var viewModel: BrewerySearchViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BrewerySearchViewModel(delegate: self)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.seachObjects.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "breweryCell", for: indexPath) as? BreweryTableViewCell else { return UITableViewCell() }
        
        let object = viewModel.seachObjects[indexPath.row]
        cell.setConfiguration(with: object)

        return cell
    }
}

extension BreweryListTableViewController: BrewerySearchViewModelDelegate {
    func searchResultsLoadedSuccessfully() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func encountered(_ error: Error) {
        print("ERROR ERROR READ ALL ABOUT IT")
    }
}

extension BreweryListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let index = searchBar.selectedScopeButtonIndex
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty,
              let endpoint = BrewerySearchEnpoint.init(index: index, searchTerm: searchTerm) else {
                  print("No text entered.")
                  return
              }
        
        viewModel.search(endpoint: endpoint)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        /// Get the type
        guard let text = searchBar.text,
                !text.isEmpty,
                let endpoint = BrewerySearchEnpoint(index: selectedScope, searchTerm: text) else { return }
        /// call fetch on viewModel
        viewModel.search(endpoint: endpoint)
    }
}
