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
    // var currentUser: User
    // user model needs to be implemented
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buyCollectionView: UIView!
    
    var searchItem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        searchItem = searchBar.text!
        
        // When the search bar is clicked, we will refresh the collection view to only
        // include items that have matching titles/descriptions that include the searched word.
        
        // TODO: Refresh BuyCollection view.
        childViewController?.searchItem = searchItem
        self.searchBar.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    var childViewController: BuyCollectionViewController?
    let childSegueName = "BuyCollectionSegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if (segue.identifier == childSegueName){
            childViewController = segue.destination as? BuyCollectionViewController
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
