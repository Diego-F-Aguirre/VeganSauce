//
//  BeerListViewController.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 5/31/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {
    
    let beerController = BeerController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BeerListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
     
        searchBar.resignFirstResponder()
    }
}

extension BeerListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return BeerController.sharedInstance.beerArray.count
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("beerCell", forIndexPath: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
        
//        let beer = BeerController.sharedInstance.beerArray[indexPath.row]
        
//        cell.updateAlcoholCell(beer)
        
        return cell
    }
}
