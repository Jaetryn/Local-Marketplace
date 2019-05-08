//
//  MessagesViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 4/23/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//


/*
 
 Description:
 
 Where the user can go to view their messages between other users and ask questions about a particular item, make offers, etc.
 
 */

import UIKit

class MessagesViewController: UIViewController {
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MessagesTableViewController
        
        destination.currentUser = currentUser
    }
}
