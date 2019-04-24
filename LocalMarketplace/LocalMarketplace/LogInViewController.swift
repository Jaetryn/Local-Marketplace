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
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
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

}
