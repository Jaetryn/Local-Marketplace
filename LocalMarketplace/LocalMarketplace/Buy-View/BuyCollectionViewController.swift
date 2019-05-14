//
//  BuyCollectionViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 4/24/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "ExistingItemCell"

class BuyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var searchItem: String = ""
    var items: [Item] = []
    var selectedItem: Item?
    var root: DatabaseReference!
    let owner = "me"
    var currentUser: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "ExistingItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExistingItemCollectionViewCell")
        root = Database.database().reference()
        loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    @objc func loadList(){
        loadData()
        self.collectionView.reloadData()
    }
    
    
    func loadData() {
        let owned = root.child("items").queryOrdered(byChild: "owner")
        owned.observeSingleEvent(of: .value, with: { (snap) in
            var newItems: [Item] = []
            for itemSnap in snap.children {
                let item = Item(snapshot: itemSnap as! DataSnapshot)
                if(self.searchItem != ""){
                    if(item.name.contains(self.searchItem)){
                        newItems.append(item)
                    }
                }else{
                    newItems.append(item)
                }
            }
            
            self.items = newItems
            self.collectionView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Register cell classes
        
        searchItem = containerViewController?.searchItem ?? searchItem
        print("searched for: " + searchItem)
        loadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    var containerViewController: BuyViewController?
    let containerSegueName = "BuyCollectionSegue"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == containerSegueName){
            containerViewController = segue.destination as? BuyViewController
        }
        
        if (segue.identifier == "ItemSegue"){
            let destination = segue.destination as! ItemDetailViewController
            print("Segue from item cell to item")
            destination.item = selectedItem
            destination.currentUser = currentUser
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        
        
        // Configure the cell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
    
        if let itemCell = cell as? ExistingItemCollectionViewCell {
            // Configure the cell...
            let item = items[indexPath.row]
            itemCell.title?.text = item.name
            //itemCell.priceLabel.text = item.price
            //itemCell.image?.image = item.image
            return itemCell
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width / 3.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    	
    }
 
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = items[indexPath.item]
        performSegue(withIdentifier: "ItemSegue", sender: self)
    }
}
