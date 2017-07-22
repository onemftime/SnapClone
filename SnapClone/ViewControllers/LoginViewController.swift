//
//  LoginViewController.swift
//  SnapClone
//
//  Created by Apple on 7/20/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("we tried to sign in")
            if error != nil {
                print("hey, we have an error:\(error!)")
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print( "We tried to create a user")
                    
                    if error != nil {
                        print("hey, we have an error:\(error!)")
                    }else {
                        
                        let ref: DatabaseReference = Database.database().reference()
                        ref.child("users").child(user!.uid).child("email").setValue(user!.email!)
                        
                        print("created user successfully!")
                        self.performSegue(withIdentifier: "loginsegue", sender: nil)                    }
                })
                
            }else {
                print("we signed in successfully")
                self.performSegue(withIdentifier: "loginsegue", sender: nil)
                
            }
        }
        
    }
    
    
    
}

