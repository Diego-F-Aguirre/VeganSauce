//
//  BeerController.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 7/29/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class BeerController {
    static let baseURL = NSURL(string:"http://www.barnivore.com/beer.json")
    static let beerEndpoint = "https://vegansauce-c6ea2.firebaseio.com/api/Beers"
    static let wineEndpoint = "https://vegansauce-c6ea2.firebaseio.com/api/Wines"
    static let liquorEndpoint = "https://vegansauce-c6ea2.firebaseio.com/api/Liquors"
    
    init() {
        BeerController.fetchBeers { (beers) in
            //
        }
    }
    
    static func fetchBeers(completion: ([Beer]) -> Void) {
        
        var beers: [Beer] = []
        
        defer {
            completion(beers)
        }
        
        guard let url = baseURL else {
            print("Error: No URL Found")
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                    print("Error: No Data Found")
                    return
            }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [[String: AnyObject]] else {
                print("Error: No JSON Found: \(responseDataString)")
                return
            }
            
            for companyDictionary in jsonDictionary {
                
                guard let company = companyDictionary["company"] as? [String: AnyObject] else {
                    print("Error: Unable to parse jsonDictionary")
                    return
                }
                
                if let beerCompany = Beer(dictionary: company) {
                    beers.append(beerCompany)
                    print("Successfully parsed information")
                }
            }
        }
    }
    
    
    static func postBarnivoreBeers() {
    }
}