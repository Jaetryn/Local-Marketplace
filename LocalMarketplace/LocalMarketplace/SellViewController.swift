//
//  SellViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 4/23/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

/*
 
 Description:
 
 Where the user can sell their item by creating a listing. A form sheet that asks details about an item including: photos, name of item being sold, price, shipping costs(?), item description, etc.
 
 */

import UIKit
import Firebase

class SellViewController: UITableViewController {
    // var currentUser: User
    // user model needs to be implemented
    
    var items: [Item] = []
    var root: DatabaseReference!
    let owner = "me"
    
    @IBOutlet var OwnedItemsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        root = Database.database().reference()
        
        loadData()
    }
    
    func loadData() {
        let owned = root.child("items").queryOrdered(byChild: "owner").queryEqual(toValue: owner)
        owned.observe(.value, with: { (snap) in
            var newItems: [Item] = []
            for itemSnap in snap.children {
                let item = Item(snapshot: itemSnap as! DataSnapshot)
                newItems.append(item)
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })
        
        owned.removeAllObservers()
    }
    
    // MARK: Actions
    @IBAction func returnToTable(_ sender: UIStoryboardSegue) {
        if let src = sender.source as? NewItemViewController {
            if let item = src.item {
                let newIndexPath = IndexPath(row: items.count, section: 0)
                items.append(item)
                let dbItem = root.child("items").childByAutoId()
                dbItem.child("name").setValue(item.name)
                dbItem.child("price").setValue(item.price)
                dbItem.child("owner").setValue(owner)
                dbItem.child("quality").setValue(item.quality)
                dbItem.child("description").setValue(item.itemDescription)
                //dbItem.child("image").setValue(item.image)
                
                OwnedItemsTable.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ownedItemCell", for: indexPath)
        
        if let itemCell = cell as? OwnedItemTableViewCell {
            // Configure the cell...
            let item = items[indexPath.row]
            itemCell.nameLabel.text = item.name
            itemCell.priceLabel.text = item.price
            itemCell.imageView?.image = item.image
            return itemCell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}


