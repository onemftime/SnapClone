//
//  LoginViewController.swift
//  SnapClone
//
//  Created by Apple on 7/20/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("we tried to sign in")
            if error != nil {
                print("hey, we have an error:\(error!)")
            }else {
                print("we signed in successfully")
                
            }
        }
        
    }
    
    
    
}

