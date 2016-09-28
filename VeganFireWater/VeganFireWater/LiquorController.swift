//
//  LiquorController.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 7/30/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class LiquorController {
    static let liquorBaseURL = NSURL(string: "http://www.barnivore.com/liquor.json")
    static let liquorEndpoint = NSURL(string:"https://vegansauce-c6ea2.firebaseio.com/api/Liquors")
    
//    init() {
//        
//        LiquorController.fetchLiquors() { (liquors) in
//            
//        }
//    }
    
    static var liquors: [Liquor] = [] {
        didSet {
            
        }
    }
    
    static func fetchLiquors(completion: ([Liquor]) -> Void) {
        
        var liquorsArray: [Liquor] = []
        
        defer {
            completion(liquorsArray)
        }
        
        guard let url = liquorBaseURL else {
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
                    if let liquorCompany = Liquor(dictionary: company) {
                        liquorsArray.append(liquorCompany)
                        self.liquors = liquorsArray
                        
                        for liquor in liquors {
                            LiquorController.postBarnivoreLiquor(liquor.id, companyName: liquor.companyName, address: liquor.address, city: liquor.city, state: liquor.state, postal: liquor.postal, country: liquor.country, phone: liquor.phone, email: liquor.email, url: liquor.url, checkedBy: liquor.checkedBy, notes: liquor.notes, status: liquor.status, statusColor: liquor.statusColor)
                        }
                    }
                })
            }
            print("Successfully parsed information")
        }
    }
    
    static func postBarnivoreLiquor(id: Int, companyName: String, address: String, city: String, state: String, postal: String, country: String, phone: String, email: String, url: String, checkedBy: String, notes: String, status: String, statusColor: String) {
        
        let liquor = Liquor(id: id, companyName: companyName, address: address, city: city, state: state, postal: postal, country: country, phone: phone, email: email, url: url, checkedBy: checkedBy, notes: notes, status: status, statusColor: statusColor)
        
        guard let url = liquor.endpoint else {
            print("Error: URL Endpoint Not Found.")
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Put, body: liquor.jsonData, completion: { (data, error) in
            
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