//
//  MessagesTableViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 4/25/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import UIKit
import Firebase

class MessagesTableViewController: UITableViewController {

    var users: [User] = []
    var root: DatabaseReference!
    var currentUser: User!
    var receiver: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        root = Database.database().reference()
        fetchUsers()
    }
    
    // Fetch users that are not the current user from database and update when new user registers
    func fetchUsers() {
        root.child("users").observeSingleEvent(of: .value, with: { snapshot in
            for userSnap in snapshot.children {
                let user = User(snapshot: userSnap as! DataSnapshot)
                if user.username != self.currentUser.username {
                    self.users.append(user)
                }
            }
            
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRow(at: indexPath!) as UITableViewCell?
        
        receiver = currentCell?.textLabel!.text
        
        performSegue(withIdentifier: "NewMessageSegue", sender: self)
    }

    // MARK: - Table view data source

    // Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Number of Rows in Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    // Fill table with other users from database
    // To-do: Fill table only with users that have chat history with current user
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)

        let user = users[indexPath.row]
        cell.textLabel?.text = user.username
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MessageLogController
        
        if segue.identifier == "NewMessageSegue" {
            destination.currentUser = currentUser
            destination.receiver = receiver
        }
    }
}
