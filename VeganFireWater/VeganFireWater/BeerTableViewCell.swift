//
//  BeerTableViewCell.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 5/31/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    @IBOutlet weak var colorIndicatorImage: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    func updateAlcoholCell(beer: String/*Beer*/) {
//        self.beer = beer
//        
//        switch colorIndicatorImage {
//        case beer.image == "Green":
//            colorIndicatorImage.image = UIImage(named: "Green_Status")
//        case beer.image == "Yellow":
//            colorIndicatorImage.image = UIImage(named: "Yellow_Status")
//        case beer.image == "Red":
//            colorIndicatorImage.image = UIImage(named: "Red_Status")
//        default:
//            break
//        }
//        
//        beerTitle.text = beer.name
//    }
}
