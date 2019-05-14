//
//  ItemViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 5/1/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import UIKit
import CoreLocation

class ItemDetailViewController: UIViewController, CLLocationManagerDelegate {
    
    var item: Item!
    var currentUser: User!
    let locationManager = CLLocationManager()

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemQuality: UILabel!
    @IBOutlet weak var itemOwner: UILabel!
    @IBOutlet weak var itemLocation: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var qualityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stylize()
        print("item coords. longitude: " + String(item.locationLong) + " latitude: " + String(item.locationLat))
    }
    
    func stylize(){
        // Add content.
        //itemImage.image = ...
        itemName.text = item?.name
        itemPrice.text = "$" + item!.price
        itemQuality.text = item?.quality
        itemDescription.text = item?.itemDescription
        itemOwner.text = "Sold by: " + item!.owner
        
        // Make it look good.
        itemName.font = itemName.font.withSize(40)
        itemPrice.font = itemName.font.withSize(20)
        itemQuality.font = itemName.font.withSize(20)
        itemDescription.font = itemName.font.withSize(15)
        itemOwner.font = itemOwner.font.withSize(15)
        itemLocation.font = itemLocation.font.withSize(15)
    
        priceLabel.layer.backgroundColor = UIColor.black.cgColor
        priceLabel.textColor = UIColor.white
        qualityLabel.layer.backgroundColor = UIColor.black.cgColor
        qualityLabel.textColor = UIColor.white
        
        messageButton.layer.backgroundColor = UIColor.black.cgColor
        messageButton.setTitleColor(UIColor.white, for: .normal)
        messageButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        
        purchaseButton.layer.backgroundColor = UIColor.red.cgColor
        purchaseButton.setTitleColor(UIColor.white, for: .normal)
        purchaseButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        
        itemImage.layer.borderWidth = 1
        itemDescription.layer.borderWidth = 1
        itemName.font = UIFont(name: "Arial-BoldMT", size: 40)
        priceLabel.font = UIFont(name: "Arial-BoldMT", size: 20)
        qualityLabel.font = UIFont(name: "Arial-BoldMT", size: 20)
        
        
        if (currentUser!.username == item!.owner){
            print("users are the same")
            messageButton.removeFromSuperview()
            purchaseButton.removeFromSuperview()
            itemLocation.removeFromSuperview()
            itemOwner.removeFromSuperview()
        }else{
            let distance = getDistance()
            var distanceString = String(distance / 1609.34)
            distanceString = truncate(distance: distanceString)
            itemLocation.text = distanceString + " miles away"
        }
    }
    
    func truncate(distance: String) -> String {
        let index = distance.firstIndex(of: ".")!
        let nextIndex = distance.index(index, offsetBy: 3)
        let newString = distance[..<nextIndex]
        return String(newString)
    }
    
    func getDistance() -> CLLocationDistance {
        let currentlyAt = locationManager.location?.coordinate
        let from = CLLocation(latitude: currentlyAt!.latitude, longitude: currentlyAt!.longitude)
        let to = CLLocation(latitude: item.locationLat, longitude: item.locationLong)
        let distance = from.distance(from: to)
        
        return distance
        
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
