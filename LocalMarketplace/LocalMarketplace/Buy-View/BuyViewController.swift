//
//  BuyViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 4/23/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

/*
 
 Description:
 
Where the user can "infinitely" scroll through a list of listings. Selecting an item will segue into a view with more detail about an item.
 
 */

import UIKit

class BuyViewController: UIViewController, UISearchBarDelegate {
    var currentUser: User!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buyCollectionView: UIView!
    @IBOutlet weak var filterSortView: UIView!
    
    var searchItem = ""
    var sortRequest = ""
    var filterRequest = ""
    var filterRequestMin = 0
    var filterRequestMax = 1000000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("current user is: " + currentUser.username)
        
        searchBar.delegate = self
        searchBar.barStyle = UIBarStyle.blackTranslucent
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        searchItem = searchBar.text!
        
        // When the search bar is clicked, we will refresh the collection view to only
        // include items that have matching titles/descriptions that include the searched word.
        
        // TODO: Refresh BuyCollection view.
        self.searchBar.endEditing(true)
        childViewController?.searchItem = self.searchItem
        childViewController?.loadData()
        childViewController?.view.setNeedsDisplay()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    var childViewController: BuyCollectionViewController?
    let childSegueName = "BuyCollectionSegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if (segue.identifier == childSegueName){
            childViewController = segue.destination as? BuyCollectionViewController
            
            childViewController!.currentUser = currentUser
            childViewController!.searchItem = searchItem
            childViewController!.sortRequest = sortRequest
            childViewController!.filterRequest = filterRequest
            childViewController!.filterRequestMin = filterRequestMin
            childViewController!.filterRequestMax = filterRequestMax
        }
        
        if (segue.identifier == "FilterSortSegue"){
            let destination = segue.destination as! FilterSortCollectionViewController
            destination.currentUser = self.currentUser
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
