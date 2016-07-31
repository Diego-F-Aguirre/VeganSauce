//
//  Wine.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 7/30/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

struct Wine {
    private let kID = "id"
    private let kCompanyName = "company_name"
    private let kAddress = "address"
    private let kCity = "city"
    private let kState = "state"
    private let kPostal = "postal"
    private let kCountry = "country"
    private let kPhone = "phone"
    private let kEmail = "email"
    private let kURL = "url"
    private let kCheckedBy = "checked_by"
    private let kNotes = "notes"
    private let kStatus = "status"
    private let kStatusColor = "red_yellow_green"
    
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
    
    init?(dictionary: [String: AnyObject]) {
        guard let id = dictionary[kID] as? Int,
            companyName = dictionary[kCompanyName] as? String,
            address = dictionary[kAddress] as? String,
            city = dictionary[kCity] as? String,
            state = dictionary[kState] as? String,
            postal = dictionary[kPostal] as? String,
            country = dictionary[kCountry] as? String,
            phone = dictionary[kPhone] as? String,
            email = dictionary[kEmail] as? String,
            url = dictionary[kURL] as? String,
            checkedBy = dictionary[kCheckedBy] as? String,
            notes = dictionary[kNotes] as? String,
            status = dictionary[kStatus] as? String,
            statusColor = dictionary[kStatusColor] as? String else { return nil }
        
        
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
    }
    
    init(id: Int, companyName: String, address: String, city: String, state: String, postal: String, country: String, phone: String, email: String, url: String, checkedBy:String, notes: String, status: String, statusColor: String) {
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
    }
    
    var dictionaryRepresentation: [String: AnyObject] {
        return [kID: id, kCompanyName: companyName, kAddress: address, kCity: city, kState: state, kPostal: postal, kCountry: country, kPhone: phone, kEmail: email, kURL: url, kCheckedBy: checkedBy, kNotes: notes, kStatus: status, kStatusColor: statusColor]
    }
    
    var jsonData: NSData? {
        return try? NSJSONSerialization.dataWithJSONObject(dictionaryRepresentation, options: .PrettyPrinted)
    }
    
    var endpoint: NSURL? {
        return WineController.wineEndpoint!.URLByAppendingPathComponent("\(identifier!.UUIDString)").URLByAppendingPathExtension("json")
    }
    
}