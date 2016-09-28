//
//  BeerListViewController.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 5/31/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
//        _ = WineController.fetchWines({ wines in
//            
//        })
        
//        _ = BeerController.fetchBeers({ beers in
//            
//        })
        
//        _ = LiquorController.fetchLiquors({ liquors in
//            
//        })
    }
}


extension BeerListViewController: UISearchBarDelegate {

}

extension BeerListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("beerCell", forIndexPath: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
        
        
        
        return cell
    }
}
