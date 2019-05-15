//
//  PurchaseViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 5/14/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController {
    var currentUser: User!
    var soldItem: Item!
    @IBOutlet weak var successLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        successLabel.text = "Purchase Successful"
        successLabel.font = UIFont(name: "Arial-BoldMT", size: 20)
        // Do any additional setup after loading the view.
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
