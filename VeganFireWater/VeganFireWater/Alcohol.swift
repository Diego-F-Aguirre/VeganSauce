//
//  Alcohol.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 9/29/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import Firebase

enum AlcoholType {
    
    case Beer
    case Wine
    case Liquor
    
    static var all: [AlcoholType] {
        return [.Beer, .Wine, .Liquor]
    }
    
    var ref: FIRDatabaseReference {
        return FIRDatabase.database().referenceWithPath("api/\(self)s")
    }
}

struct Alcohol {

    var id: Int
    var companyName: String
    var address: String
    var city: String
    var state: String
    var postal: String
    var country: String
    var phone: String
    var email: String
    var url: String
    var checkedBy: String
    var notes: String
    var status: String
    var statusColor: String
    var identifier: NSUUID?
    var barnivoreChecked: Bool?
    var alcoholType: AlcoholType
    
    init?(dictionary: [String: AnyObject], type: AlcoholType) {
        
        guard
            let id = dictionary[Constants.kID] as? Int,
            let companyName = dictionary[Constants.kCompanyName] as? String,
            let address = dictionary[Constants.kAddress] as? String,
            let city = dictionary[Constants.kCity] as? String,
            let state = dictionary[Constants.kState] as? String,
            let postal = dictionary[Constants.kPostal] as? String,
            let country = dictionary[Constants.kCountry] as? String,
            let phone = dictionary[Constants.kPhone] as? String,
            let email = dictionary[Constants.kEmail] as? String,
            let url = dictionary[Constants.kURL] as? String,
            let checkedBy = dictionary[Constants.kCheckedBy] as? String,
            let notes = dictionary[Constants.kNotes] as? String,
            let status = dictionary[Constants.kStatus] as? String,
            let statusColor = dictionary[Constants.kStatusColor] as? String else { return nil }
            //let barnivoreChecked = dictionary[Constants.kBarnivoreChecked] as? Bool else { return nil }
        
        self.id = id
        self.companyName = companyName
        self.address = address
        self.city = city
        self.state = state
        self.postal = postal
        self.country = country
        self.phone = phone
        self.email = email
        self.url = url
        self.checkedBy = checkedBy
        self.notes = notes
        self.status = status
        self.statusColor = statusColor
//        self.barnivoreChecked = barnivoreChecked
        self.alcoholType = type
    }
    
    init(id: Int, companyName: String, address: String, city: String, state: String, postal: String, country: String, phone: String, email: String, url: String, checkedBy:String, notes: String, status: String, statusColor: String, barnivoreChecked: Bool = true, alcoholType: AlcoholType) {
        
        self.id = id
        self.companyName = companyName
        self.address = address
        self.city = city
        self.state = state
        self.postal = postal
        self.country = country
        self.phone = phone
        self.email = email
        self.url = url
        self.checkedBy = checkedBy
        self.notes = notes
        self.status = status
        self.statusColor = statusColor
        self.identifier =  NSUUID()
        self.barnivoreChecked = barnivoreChecked
        self.alcoholType = alcoholType
    }
}

extension Alcohol {
    
//    var endpoint: NSURL? {
//        
//        switch alcoholType {
//        case .Beer:
//            return BeerController.beerEndpoint!.URLByAppendingPathComponent("\(identifier!.UUIDString)")!.URLByAppendingPathExtension("json")
//        case .Liquor:
//            return LiquorController.liquorEndpoint?.URLByAppendingPathComponent("\(identifier!.UUIDString)")!.URLByAppendingPathExtension("json")
//        case .Wine:
//            return WineController.wineEndpoint?.URLByAppendingPathComponent("\(identifier!.UUIDString)")!.URLByAppendingPathExtension("json")
//        }
//    }
    
    var dictionaryRepresentation: [String: AnyObject] {
        return [Constants.kID: id, Constants.kCompanyName: companyName, Constants.kAddress: address, Constants.kCity: city, Constants.kState: state, Constants.kPostal: postal, Constants.kCountry: country, Constants.kPhone: phone, Constants.kEmail: email, Constants.kURL: url, Constants.kCheckedBy: checkedBy, Constants.kNotes: notes, Constants.kStatus: status, Constants.kStatusColor: statusColor]//, Constants.kBarnivoreChecked: barnivoreChecked]
    }
    
//    var jsonData: NSData? {
//        return try? NSJSONSerialization.dataWithJSONObject(dictionaryRepresentation, options: .PrettyPrinted)
//    }
}
