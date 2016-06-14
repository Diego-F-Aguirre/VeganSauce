//
//  Beer.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 5/31/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit


class Beer {
    private let kname = "company_name"
    private let kImage = "red_yellow_green"
//    private let kNotes = "notes"
//    private let kPhone = "phone"
//    private let kStatus = "status"
    
    
    var name: String
    var image: String
//    var notes: String
//    var phone: String
//    var status: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let companyDictionary = dictionary["company"] as? [String: AnyObject],
            name = companyDictionary[kname] as? String,
            image = companyDictionary[kImage] as? String
            /*notes = dictionary[kNotes] as? String,
             phone = dictionary[kPhone] as? String,
             status = dictionary[kStatus] as? String */ else { return nil }
        
        self.name = name
        self.image = image
        //        self.notes = notes
        //        self.phone = phone
        //        self.status = status
    }
}