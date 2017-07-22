//
//  SelectUserViewController.swift
//  SnapClone
//
//  Created by Apple on 7/21/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var users: [User] = []
    let ref: DatabaseReference = Database.database().reference()
    var imageURL = ""
    var descrip = ""
    var uuid = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.ref.child("users").observe(DataEventType.childAdded) { (snapshot) in
            
            print (snapshot)
            
            let user = User()
            let snapshotvalue = snapshot.value as? NSDictionary
            
            user.email = snapshotvalue!["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        let snap = ["from":Auth.auth().currentUser!.email!, "descripion":descrip, "imageURL":imageURL, "uuid":uuid]
        self.ref.child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        navigationController!.popToRootViewController(animated: true)
        
    }
    
}
