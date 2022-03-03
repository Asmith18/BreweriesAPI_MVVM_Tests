//
//  HomePageViewController.swift
//  Breweries_MVVM_Tests
//
//  Created by adam smith on 2/19/22.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchViewController()
    }
    
    private func setUpSearchViewController() {
        let storyboard = UIStoryboard(name: "BrewerySearchViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as? BreweryListTableViewController
        navigationItem.searchController = UISearchController(searchResultsController: viewController)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.delegate = viewController as? UISearchBarDelegate
    }
}
