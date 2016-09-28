//
//  FirebaseController.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 9/27/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let FIRDatabase = FIRDatabaseReference()
    static let ref = FIRDatabase.database.reference()
   }

protocol FirebaseType {
    
    var identifier: String? { get set }
    var endpoint: String { get }
    var jsonValue: [String: AnyObject] { get }
    
    init?(json: [String : AnyObject], identifier: String)
    
    mutating func save()
    func delete()
}

extension FirebaseType {
    
    mutating func save() {
        
        var endpointBase: FIRDatabaseReference
        
        if let identifier = self.identifier {
            endpointBase = FirebaseController.ref.child(endpoint).child(identifier)
        } else {
            endpointBase = FirebaseController.ref.child(endpoint).childByAutoId()
            self.identifier = endpointBase.key
        }
        endpointBase.updateChildValues(self.jsonValue)
    }
    
    func delete() {
        
        if let identifier = self.identifier {
            let endpointBase: FIRDatabaseReference = FirebaseController.ref.child(endpoint).child(identifier)
            endpointBase.removeValue()
        }
    }
}

