//
//  ItemViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 5/1/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var item: Item?
    var currentUser: User?

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var qualityLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemNameLabel.text = item?.name
        priceLabel.text = item?.price
        qualityLabel.text = item?.quality
        descriptionLabel.text = item?.itemDescription
        ownerLabel.text = item?.owner
        
    }
    
    /*
 var name: String
 var price: String
 var itemDescription: String
 var quality: String
 var image: UIImage?
 var imagePath: String?
 var location: String // TEMPORARY, will add location support
 var owner: String
 */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
