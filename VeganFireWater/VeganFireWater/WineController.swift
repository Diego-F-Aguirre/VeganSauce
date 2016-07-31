//
//  WineController.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 7/30/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class WineController {
    static let wineBaseURL = NSURL(string: "http://www.barnivore.com/wine.json")
    static let wineEndpoint = NSURL(string:"https://vegansauce-c6ea2.firebaseio.com/api/Wines")
    
//    init() {
//        
//        WineController.fetchWines() { (wines) in
//            
//        }
//    }
    
    static var wines: [Wine] = [] {
        didSet {
            
        }
    }
    
    static func fetchWines(completion: ([Wine]) -> Void) {
        
        var winesArray: [Wine] = []
        
        defer {
            completion(winesArray)
        }
        
        guard let url = wineBaseURL else {
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
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let wineCompany = Wine(dictionary: company) {
                        winesArray.append(wineCompany)
                        self.wines = winesArray
                        
                        for wine in wines {
                            WineController.postBarnivoreWines(wine.id, companyName: wine.companyName, address: wine.address, city: wine.city, state: wine.state, postal: wine.postal, country: wine.country, phone: wine.phone, email: wine.email, url: wine.url, checkedBy: wine.checkedBy, notes: wine.notes, status: wine.status, statusColor: wine.statusColor)
                        }
                    }
                })
            }
            print("Successfully parsed information")
        }
    }
    
    static func postBarnivoreWines(id: Int, companyName: String, address: String, city: String, state: String, postal: String, country: String, phone: String, email: String, url: String, checkedBy: String, notes: String, status: String, statusColor: String) {
        
        let wine = Wine(id: id, companyName: companyName, address: address, city: city, state: state, postal: postal, country: country, phone: phone, email: email, url: url, checkedBy: checkedBy, notes: notes, status: status, statusColor: statusColor)
        
        guard let url = wine.endpoint else {
            print("Error: URL Endpoint Not Found.")
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Put, body: wine.jsonData, completion: { (data, error) in
            
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                    print("Error: No Data found")
                    return
            }
            
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            } else if responseDataString.containsString("error") {
                print("Error: \(responseDataString)")
            } else {
                print("Successfully uploaded beers to api!")
            }
        })
    }
}