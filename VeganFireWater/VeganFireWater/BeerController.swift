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
    
    func fetchAlcohol(completion:(beers : [Beer]) -> Void ) {
        guard let url = NSURL(string: beerURL) else {
            print("No URL Found")
            completion(beers: [])
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            
            if error != nil {
                completion(beers: [])
                print("Error: \(error?.localizedDescription)")
            } else {
                
                guard let data = data,
                    responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                        print("Error: No Data found")
                        completion(beers: [])
                        return
                }
                
                guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [[String: AnyObject]] else
                {
                    print("Unable to serialize JSON, /n\(responseDataString)")
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let beerArray = jsonDictionary.flatMap({Beer(dictionary: $0)})
                    self.beers = beerArray
                    for beer in beerArray {
                        print(beer.name)
                    }
                    completion(beers: beerArray)
                })
            }
        }
    }
}
