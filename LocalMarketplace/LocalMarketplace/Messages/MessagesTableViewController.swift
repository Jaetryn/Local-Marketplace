//
//  MessagesTableViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 4/25/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {

    // var currentUser: User
    // user model needs to be implemented
    
    // Data should be a 2d array of conversation objects. Conversation objects should contain an array of messages with an associated value for each message depicting who the "sender" is. And (optional) time when the message was sent. I need at least the sender information so I can format the message view accordingly.
    
    var data = [["Message 1", "hey", "sup lol", "bro how much for that supreme shirt"],["Message 2"],["Message 3"]] // Placeholder.
    
    // Populate this 2D array with an array of conversations -> the conversation. (Based on user variable)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)

        // Configure the cell...

        cell.textLabel?.text = data[indexPath.item][0]

        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identity = segue.identifier
        let dest = segue.destination as! MessageTableViewController
        
        if identity == "MessageSegue" {
            dest.conversation = data[0]
        }

        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
