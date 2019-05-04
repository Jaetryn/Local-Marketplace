//
//  SignUpViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 4/23/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

/*
 
 Description:
 
 Where the user can sign up to create an account.
 
 Segue'd from the entry point of the app. (Means they aren't already logged in.)
 
 */

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var fieldStack: UIStackView!
    
    var root: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        root = Database.database().reference()
        // Do any additional setup after loading the view.
        
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        cancelButton.layer.backgroundColor = UIColor.black.cgColor
        
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signUpButton.layer.backgroundColor = UIColor.black.cgColor
        
        usernameField.layer.borderColor = UIColor.black.cgColor
        usernameField.layer.borderWidth = 1
        
        passwordField.layer.borderColor = UIColor.black.cgColor
        passwordField.layer.borderWidth = 1
        
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.layer.borderWidth = 1
        
}
    
    @IBAction func signUpAction(_ sender: Any) {
        if(usernameField.text != nil && passwordField.text != nil && emailField.text != nil){
            let newUser = User(username: usernameField.text!, password: passwordField.text!, email: emailField.text!)
            
            // Add user to the database.
            let dbItem = root.child("users").childByAutoId()
            dbItem.child("username").setValue(newUser.username)
            dbItem.child("password").setValue(newUser.password) // Should encrypt this.. but yeah.
            dbItem.child("email").setValue(newUser.email)
            dbItem.child("funds").setValue(newUser.funds)
            
            
            performSegue(withIdentifier: "SignUpConfirmSegue", sender: nil)
            // Done. Now go back to log in page.
        }else{
            // Tell user to make sure all fields are filled out.
        }
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
