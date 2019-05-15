//
//  SortTableViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 5/13/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import UIKit

class SortTableViewController: UITableViewController {

    let options = ["Price (Ascending)", "Price (Descending)", "Distance (Ascending)", "Distance (Descending)", "Clear"]
    var request = ""
    var currentUser: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("current user is: " + currentUser.username)        // Uncomment the following line to preserve selection between presentations
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
        return options.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.options[indexPath.row]

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
        if(segue.identifier == "SortRequestSegue"){
            let destination = segue.destination as! BuyViewController
            destination.sortRequest = self.request
            destination.currentUser = self.currentUser
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.options[indexPath.row] == "Clear"){
            self.request = ""
        }else{
            self.request = self.options[indexPath.row]
        }
        performSegue(withIdentifier: "SortRequestSegue", sender: self)
    }

}
