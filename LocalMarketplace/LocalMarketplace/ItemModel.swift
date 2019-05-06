//
//  ItemModel.swift
//  SemesterProject
//
//  Created by Ben Bellis on 4/19/19.
//  Copyright © 2019 Ben Bellis. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import CoreLocation

// Messing around, could add this
enum ItemQuality: String {
    case new = "New"
    case slightlyUsed = "Slightly Used"
    case moderatelyUsed = "Moderately Used"
    case damaged = "Damaged"
}

class Item {
    var name: String
    var price: String
    var itemDescription: String
    var quality: String
    var image: UIImage?
    var imagePath: String?
    var location: String // TEMPORARY, will add location support
    var owner: String
    var ref: DatabaseReference?
    
    init(name: String, price: String, quality: String, desc: String, owner: String, img: UIImage?) {
        self.name = name
        self.price = price
        self.itemDescription = desc
        self.quality = quality
        image = img
        self.location = "here"
        self.owner = owner
    }
    
    init(snapshot: DataSnapshot) {
        let data = snapshot.value as! Dictionary<String, Any>
        if let name = data["name"] as? String {
            self.name = name
        } else { self.name = "" }
        if let price = data["price"] as? String {
            self.price = price
        } else { self.price = "" }
        if let desc = data["description"] as? String {
            self.itemDescription = desc
        } else { self.itemDescription = "" }
        if let owner = data["owner"] as? String {
            self.owner = owner
        } else { self.owner = "" }
        if let quality = data["quality"] as? String {
            self.quality = quality
        } else { self.quality = "" }
        //        if let image = data["image"] as? UIImage {
        //            self.image = image
        //        } else { image = nil }
        
        location = "here"
        
        ref = snapshot.ref
    }
}
