////
////  AlcoholController.swift
////  VeganFireWater
////
////  Created by Diego Aguirre on 10/1/16.
////  Copyright © 2016 home. All rights reserved.
////
//
//import Foundation
//
//class AlcoholController {
//    
//    static let beerBaseURL = NSURL(string:"http://www.barnivore.com/beer.json")
//    static let beerEndpoint = NSURL(string:"https://vegansauce-c6ea2.firebaseio.com/api/Beers")
//    static let alcoholEndpoint = NSURL(string: "https://vegansauce-c6ea2.firebaseio.com/api/\(Type)")
//    static let wineBaseURL = NSURL(string: "http://www.barnivore.com/wine.json")
//    static let wineEndpoint = NSURL(string:"https://vegansauce-c6ea2.firebaseio.com/api/Wines")
//    
//    
//    //    init() {
//    //
//    //        BeerController.fetchBeers { beers in
//    //
//    //        }
//    //    }
//    
//    static var beers: [Beer] = [] {
//        didSet {
//            
//        }
//    }
//    
//    static func fetchBeers(completion: ([Beer]) -> Void) {
//        
//        var beersArray: [Beer] = []
//        
//        defer {
//            completion(beersArray)
//        }
//        
//        guard let url = beerBaseURL else {
//            print("Error: No URL Found")
//            return
//        }
//        
//        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
//            guard let data = data,
//                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
//                    print("Error: No Data Found")
//                    return
//            }
//            
//            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [[String: AnyObject]] else {
//                print("Error: No JSON Found: \(responseDataString)")
//                return
//            }
//            
//            for companyDictionary in jsonDictionary {
//                
//                guard let company = companyDictionary["company"] as? [String: AnyObject] else {
//                    print("Error: Unable to parse jsonDictionary")
//                    return
//                }
//                
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    if let beerCompany = Beer(dictionary: company) {
//                        beersArray.append(beerCompany)
//                        self.beers = beersArray
//                        
//                        for beer in beers {
//                            BeerController.postBarnivoreBeers(beer.id, companyName: beer.companyName, address: beer.address, city: beer.city, state: beer.state, postal: beer.postal, country: beer.country, phone: beer.phone, email: beer.email, url: beer.url, checkedBy: beer.checkedBy, notes: beer.notes, status: beer.status, statusColor: beer.statusColor)
//                        }
//                    }
//                })
//            }
//            print("Successfully parsed information")
//        }
//    }
//    
//    static func postBarnivoreBeers(id: Int, companyName: String, address: String, city: String, state: String, postal: String, country: String, phone: String, email: String, url: String, checkedBy: String, notes: String, status: String, statusColor: String) {
//        
//        let beer = Beer(id: id, companyName: companyName, address: address, city: city, state: state, postal: postal, country: country, phone: phone, email: email, url: url, checkedBy: checkedBy, notes: notes, status: status, statusColor: statusColor)
//        
//        guard let url = beer.endpoint else {
//            print("Error: URL Endpoint Not Found.")
//            return
//        }
//        
//        NetworkController.performRequestForURL(url, httpMethod: .Put, body: beer.jsonData, completion: { (data, error) in
//            
//            guard let data = data,
//                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
//                    print("Error: No Data found")
//                    return
//            }
//            
//            if error != nil {
//                print("Error: \(error?.localizedDescription)")
//            } else if responseDataString.containsString("error") {
//                print("Error: \(responseDataString)")
//            } else {
//                print("Successfully uploaded beers to api!")
//            }
//        })
//    }
//}
