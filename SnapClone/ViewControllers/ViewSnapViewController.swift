//
//  ViewSnapViewController.swift
//  SnapClone
//
//  Created by Apple on 7/21/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = snap.descrip
        imageView.sd_setImage(with: URL(string: snap.imageURL))
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("goodbye")
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        Storage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("we deleted it")
        }
        
        
    }
    
}
