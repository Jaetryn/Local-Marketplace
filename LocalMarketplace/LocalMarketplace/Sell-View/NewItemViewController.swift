//
//  NewItemViewController.swift
//  SemesterProject
//
//  Created by Ben Bellis on 4/19/19.
//  Copyright © 2019 Ben Bellis. All rights reserved.
//

import UIKit
import Photos
import AVKit
import CoreLocation

 class NewItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    var item: Item?
    var currentUser: User!
    var imagePickerController = UIImagePickerController()
    let locationManager = CLLocationManager()
    
    //MARK: - Outlets
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var NameInput: UITextField!
    @IBOutlet weak var PriceInput: UITextField!
    @IBOutlet weak var QualityInput: UITextField!
    @IBOutlet weak var DescriptionInput: UITextView!
    
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // Do any additional setup after loading the view.
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    }
    
    // MARK: - Photos
    @IBAction func PhotoButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Add Image", message: "", preferredStyle: .actionSheet)
        let cameraError = UIAlertController(title: "Error", message: "Camera is not available", preferredStyle: .alert)
        cameraError.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (action) in
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler:
            { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.imagePickerController.sourceType = .camera
                    let authStatus = PHPhotoLibrary.authorizationStatus()
                    if authStatus != .authorized {
                        PHPhotoLibrary.requestAuthorization({status in
                            return
                        })
                    }
                    if PHPhotoLibrary.authorizationStatus() == .authorized {
                        self.present(self.imagePickerController, animated: true)
                    }
                } else {
                    self.present(cameraError, animated: true)
                }
        })
        )
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:
            { (action) in
                self.imagePickerController.sourceType = .photoLibrary
                let authStatus = PHPhotoLibrary.authorizationStatus()
                if authStatus != .authorized {
                    PHPhotoLibrary.requestAuthorization({status in
                        return
                    })
                }
                if PHPhotoLibrary.authorizationStatus() == .authorized {
                    self.present(self.imagePickerController, animated: true)
                }
        })
        )
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:
            { (action) in })
        )
        
        present(actionSheet, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.originalImage] as? UIImage {
            ItemImage.image = image
        } else {
            print("Error with image")
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let button = sender as? UIBarButtonItem {
            if button === SaveButton {
                let name = NameInput.text ?? "name"
                let price = PriceInput.text ?? "price"
                let quality = QualityInput.text ?? "quality"
                let description = DescriptionInput.text ?? "description"
                let image = ItemImage.image ?? nil
                let locationLong = locationManager.location?.coordinate.longitude
                let locationLat = locationManager.location?.coordinate.latitude
                
                item = Item(name: name, price: price, quality: quality, desc: description, owner: currentUser.username, img: image, lat: locationLat!, long: locationLong!)
                
                // Update buycollection view controller to include new item.
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
