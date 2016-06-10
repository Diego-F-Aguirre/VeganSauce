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
    static let beerURL = "http://barnivore.com/beer.json"
    static let wineURL = "http://barnivore.com/wine.json"
    static let liquorURL = "http://barnivore.com/liquor.json"
    
    var beers: [Beer] = []
    
    init() {
        BeerController.fetchAlcohol { (beers) in
            
        }
    }
    
    static func fetchAlcohol(completion: (beers: [Beer]) -> Void) {
//        guard let alcoholEscapedString = title.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()) else { return }
//        let urlString = baseURL + "/search.json?keyword=" + alcoholEscapedString
        guard let url = NSURL(string: beerURL) else { return }
        
//        var beerArray: [Beer] = []
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data,
                jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [[String: AnyObject]] else
           {
                    completion(beers: [])
                    return
            }
            
            print(jsonDictionary)
            
            
            
            
        }
        
    }
    
    
    
    
}