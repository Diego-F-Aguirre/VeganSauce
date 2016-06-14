//
//  BeerListViewController.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 5/31/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {
    
    //    let beerController = BeerController()
    @IBOutlet weak var tableView: UITableView!
    var beers: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BeerController.sharedInstance.fetchAlcohol { (beers) in
            self.beers = beers
            self.tableView.reloadData()
        }
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
        return beers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("beerCell", forIndexPath: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
        
        let beer = beers[indexPath.row]
        
        cell.updateAlcoholCell(beer)
        
        return cell
    }
}
