//
//  UserViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 5/6/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController {
    var currentUser: User!
    var root: DatabaseReference!

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var funds: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        style()
    }
    
    func style() {
        // content
        username.text = currentUser.username
        funds.text = "$" + String(currentUser.funds)
        
        // style
        username.font = UIFont(name: "Arial-BoldMT", size: 60)
        
        funds.font = UIFont(name: "Arial-BoldMT", size: 20)
        
        logout.backgroundColor = UIColor.black
        logout.setTitleColor(UIColor.white, for: .normal)
        logout.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "LogOutSegue"){
            saveUserState()
            
            let dest = segue.destination as! LogInViewController
            dest.currentUser = nil
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func saveUserState(){
        currentUser.ref!.child("funds").setValue(currentUser.funds)
    }

}
