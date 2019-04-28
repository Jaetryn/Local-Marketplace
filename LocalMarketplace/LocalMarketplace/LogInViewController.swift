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

class LogInViewController: UIViewController {
    // var currentUser: User
    // user model needs to be implemented
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func logInButtonPress(_ sender: Any) {
        // Check if user + pass combo is correct.
        print("log in button pressed")
    }
    
    @IBAction func signUpButtonPress(_ sender: Any) {
        print("sign up button pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let dest = segue.destination
        
        if identity == "loggedIn" {
            print("loggedIn")
        }
        
        if identity == "login" {
            print("login")
        }
        
        if identity == "signup" {
            print("signup")
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // Conditional segue for login. Only segues to app if user/pass combo is correct.
    //To be updated when user model and database is setup. Right now, use "user" and "pass" as values.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "login" {
            if (usernameField.text == "user" && passwordField.text == "pass"){
                print("correct user/pass, segue to app")
                return true
            }else{
                print("incorrect user/pass, will not segue")
                return false
            }
        }
        return true
    }

}
