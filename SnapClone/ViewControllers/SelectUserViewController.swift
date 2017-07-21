//
//  SelectUserViewController.swift
//  SnapClone
//
//  Created by Apple on 7/21/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var users: [User] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let ref: DatabaseReference = Database.database().reference()
        ref.child("users").observe(DataEventType.childAdded) { (snapshot) in
            
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
    
}
