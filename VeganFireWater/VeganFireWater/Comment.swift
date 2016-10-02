//
//  Comment.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 9/27/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

struct Comment {
    
    private let textKey = "text"
    private let timeStampKey = "time_stamp"
    private let veganVerifiedKey = "vegan_verified"
    private let veganConfirmedKey = "vegan_confirmed"
    private let veganDebunkedKey = "vegan_debunked"
    private let alcoholKey = "alcohol"
    
    let text: String
    let timeStamp: NSDate
    var alcohol: Alcohol
    var veganConfirmed: Int
    var veganDebunked: Int
    
    var veganVerified: Bool {
        didSet {
            if true  {
              veganConfirmed += 1
            } else {
                veganDebunked += 1
            }
        }
    }

    var alcoholID: String {
        get {
            var newID: String = ""
            
            if alcohol.alcoholType == .Beer {
                newID = String(alcohol.identifier)
            } else if alcohol.alcoholType == .Wine {
                newID = String(alcohol.identifier)
            } else if alcohol.alcoholType == .Liquor {
                newID = String(alcohol.identifier)
            }
            return newID
        }
    }
    
    init?(dictionary: [String: AnyObject]) {
        
        guard let text = dictionary[textKey] as? String,
            let timeStamp = dictionary[timeStampKey] as? NSDate,
            let alcohol = dictionary[alcoholKey] as? Alcohol,
            let veganConfirmed = dictionary[veganConfirmedKey] as? Int,
            let veganDebunked = dictionary[veganDebunkedKey] as? Int,
            let veganVerified = dictionary[veganVerifiedKey] as? Bool else {
                print("Error: Failable Initializer Failed!!!")
                return nil
        }
        self.text = text
        self.timeStamp = timeStamp
        self.alcohol = alcohol
        self.veganConfirmed = veganConfirmed
        self.veganDebunked = veganDebunked
        self.veganVerified = veganVerified
    }
    
    init(text: String, timeStamp: NSDate, alcohol: Alcohol, veganVerified: Bool, veganConfirmed: Int, veganDebunked: Int) {
        
        self.text = text
        self.timeStamp = NSDate()
        self.alcohol = alcohol
        self.veganVerified = veganVerified
        self.veganConfirmed = veganConfirmed
        self.veganDebunked = veganDebunked
    }
}
