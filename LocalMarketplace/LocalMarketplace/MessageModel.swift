//
//  MessageModel.swift
//  LocalMarketplace
//
//  Created by user153533 on 4/28/19.
//  Copyright © 2019 Andrew Yuen. All rights reserved.
//

import Foundation
import Firebase

// To-do: Add timestamps
class Message {
    var to: String?
    var text: String?
    var from: String?
    
    var ref: DatabaseReference?
    
    init(to: String?, text: String?, from: String?) {
        self.to = to
        self.text = text
        self.from = from
    }
    
    init(snapshot: DataSnapshot) {
        let data = snapshot.value as! Dictionary<String, Any>
        let to = data["to"] as! String
        let text = data["text"] as! String
        let from = data["from"] as! String
        
        self.to = to
        self.text = text
        self.from = from
        
        self.ref = snapshot.ref
    }
}
