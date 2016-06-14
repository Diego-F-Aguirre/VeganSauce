//
//  BeerController.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 5/31/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class BeerController {
    static let sharedInstance = BeerController()
    
    static let baseURL = "https://barnivore.com"
    let beerURL = "http://barnivore.com/beer.json"
    static let wineURL = "http://barnivore.com/wine.json"
    static let liquorURL = "http://barnivore.com/liquor.json"
    
    var beers: [Beer] = []
    
//    init() {
//        beers = fetchAlcohol({ (beers) in
//            <#code#>
//        })
//    }
    
//    init() {
//        BeerController.fetchAlcohol { (beers) in
//            
//        }
//    }
    
    func fetchAlcohol(completion: (beers: [Beer]) -> Void) {
        guard let url = NSURL(string: beerURL) else { return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data,
                jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [[String: AnyObject]] else
            {
                completion(beers: [])
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let beerArray = jsonDictionary.flatMap({Beer(dictionary: $0)})
                
                for i in beerArray {
                    print(i.name)
                }
                completion(beers: beerArray)
            })
        }
    }
}