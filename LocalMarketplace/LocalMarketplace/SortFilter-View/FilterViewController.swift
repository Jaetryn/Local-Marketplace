//
//  FilterViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 5/14/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITextFieldDelegate {
    
    var currentUser: User!
    var chosen: String!
    var min = 0
    var max = 1000000
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var minEntry: UITextField!
    @IBOutlet weak var maxEntry: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.minEntry.delegate = self;
        self.maxEntry.delegate = self;

        filterLabel.text = chosen
        toLabel.text = "TO"
        filterLabel.font = UIFont(name: "Arial-BoldMT", size: 40)
        
        toLabel.font = UIFont(name: "Arial-BoldMT", size: 20)
        
        minEntry.layer.borderColor = UIColor.black.cgColor
        minEntry.layer.borderWidth = 1
        
        maxEntry.layer.borderColor = UIColor.black.cgColor
        maxEntry.layer.borderWidth = 1
        
        applyButton.titleLabel?.textColor = UIColor.white
        applyButton.backgroundColor = UIColor.black
        applyButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func applyPress(_ sender: UIButton) {
        self.min = Int(minEntry.text!)!
        self.max = Int(maxEntry.text!)!
        performSegue(withIdentifier: "FilterRequestSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "FilterRequestSegue"){
            let destination = segue.destination as! BuyViewController
            destination.currentUser = self.currentUser
            destination.filterRequest = chosen
            destination.filterRequestMin = min
            destination.filterRequestMax = max
        }
    }
    

}
