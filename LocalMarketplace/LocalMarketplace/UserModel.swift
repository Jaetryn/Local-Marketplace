//
//  userModel.swift
//  LocalMarketplace
//
//  Created by user150985 on 5/4/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import CoreLocation

class User {
    var username: String
    var password: String
    var email: String
    var funds: Double
    //var favorites: [Item]
    
    var ref: DatabaseReference?
    
    init(username: String, password: String, email: String){
        self.username = username
        self.password = password
        self.email = email
        self.funds = 100.00 // Each user starts off with $100.00
        //self.favorites = []
    }
    
    init(snapshot: DataSnapshot){
        let data = snapshot.value as! Dictionary<String, Any>
        let username = data["username"] as! String
        let password = data["password"] as! String
        let email = data["email"] as! String
        let funds = data["funds"] as! Double
        
        self.username = username
        self.password = password
        self.email = email
        self.funds = funds
        
        self.ref = snapshot.ref
    }
    
}
