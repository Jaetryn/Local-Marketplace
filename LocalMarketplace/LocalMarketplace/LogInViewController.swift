//
//  LogInViewController.swift
//  LocalMarketplace
//
//  Created by user150985 on 4/23/19.
//  Copyright © 2019 John Trinh. All rights reserved.
//

/*
 
 Description:
 
 The entry point into the app. Has log-in and sign-up buttons that lead to their own views.
 
 When logging in, we will transition into the main app. When signing up, we will transition into the sign up view.
 
 This entry point will be automatically skipped and forwarded into the main app if the user is already logged in.
 
 */

import UIKit
import Firebase

class LogInViewController: UIViewController {
    var currentUser: User?
    var root: DatabaseReference!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func logInButtonPress(_ sender: Any) {
        // Check if user + pass combo is correct.
        if(usernameField.text != nil && passwordField.text != nil){
            let found = root.child("users").queryOrdered(byChild: "username").queryEqual(toValue: usernameField.text!)
            // username found, check password to corresponding username.
            found.observeSingleEvent(of: .value, with: { (snap) in
                for itemSnap in snap.children {
                    let userDB = User(snapshot: itemSnap as! DataSnapshot)
                    if(userDB.password == self.passwordField.text!){
                        self.currentUser = userDB
                        self.performSegue(withIdentifier: "LogInSegue", sender: nil)
                    }else{
                        // Tell user to check log in credentials.
                    }
                }
            })

            
        }
        print("log in button pressed")
    }
    
    @IBAction func signUpButtonPress(_ sender: Any) {
        performSegue(withIdentifier: "SignUpSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        root = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // If the user is already logged in, segue to the buy view.
        if (false) {
            self.performSegue(withIdentifier: "loggedin", sender: nil)
        }
        
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor.black.cgColor
        logInButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        logInButton.layer.backgroundColor = UIColor.black.cgColor
        
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor.black.cgColor
        signInButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signInButton.layer.backgroundColor = UIColor.black.cgColor
        
        usernameField.layer.borderColor = UIColor.black.cgColor
        usernameField.layer.borderWidth = 1
        
        passwordField.layer.borderColor = UIColor.black.cgColor
        passwordField.layer.borderWidth = 1
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let identity = segue.identifier
        
        if identity == "loggedIn" {
            print("loggedIn")
        }
        
        if identity == "LogInSegue" {
            let tabBar = segue.destination as! UITabBarController
            
            let nav = tabBar.viewControllers![0] as! UINavigationController
            let dest = nav.topViewController as! BuyViewController
            dest.currentUser = self.currentUser
            

            let nav2 = tabBar.viewControllers![1] as! UINavigationController
            let dest2 = nav2.topViewController as! SellViewController
            dest2.currentUser = self.currentUser
        
            let nav3 = tabBar.viewControllers![2] as! UINavigationController
            let dest3 = nav3.topViewController as! MessagesViewController
            dest3.currentUser = self.currentUser
            
            let dest4 = tabBar.viewControllers![3] as! UserViewController

            dest4.currentUser = self.currentUser
            print("Successful log in.")
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // Conditional segue for login. Only segues to app if user/pass combo is correct.
    //To be updated when user model and database is setup. Right now, use "user" and "pass" as values.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }

}
