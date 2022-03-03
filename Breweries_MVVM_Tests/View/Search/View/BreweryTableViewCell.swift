//
//  BreweryTableViewCell.swift
//  Breweries_MVVM_Tests
//
//  Created by adam smith on 2/19/22.
//

import UIKit

class BreweryTableViewCell: UITableViewCell {

    @IBOutlet weak var TitleNameLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var typeTitleLabel: UILabel!
    @IBOutlet weak var addressTextLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        TitleNameLabel.text = nil
        addressTextLabel.text = nil
        typeTitleLabel.text = nil
    }
    
    func setConfiguration(with object: BreweryResults) {
        TitleNameLabel.text = object.name
        addressTextLabel.text = object.street
        typeTitleLabel.text = object.breweryType
        locationNameLabel.text = "\(object.city)/\(object.state)"
    }
}
