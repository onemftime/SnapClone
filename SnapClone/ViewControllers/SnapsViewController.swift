//
//  SnapsViewController.swift
//  SnapClone
//
//  Created by Apple on 7/21/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ref: DatabaseReference = Database.database().reference()
    
    var snaps : [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("snaps").observe(DataEventType.childAdded) { (snapshot) in
            
            print (snapshot)
            
            let snap = Snap()
            
            let snapshotvalue = snapshot.value as? NSDictionary
            
            snap.imageURL = snapshotvalue!["imageURL"] as! String
            snap.from = snapshotvalue!["from"] as! String
            snap.descrip = snapshotvalue!["descripion"] as! String
            snap.key = snapshot.key
            snap.uuid = snapshotvalue!["uuid"] as! String
            
            
            self.snaps.append(snap)
            self.tableView.reloadData()
        }
        
        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("snaps").observe(DataEventType.childRemoved) { (snapshot) in
            
            print (snapshot)
            
            var index = 0
            
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
                index += 1
                
            }
            
            self.tableView.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        }else{
            return snaps.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if snaps.count == 0 {
            
            cell.textLabel?.text = "you have no snaps 😃"
        } else {
            
            let snap = snaps [indexPath.row]
            cell.textLabel?.text = snap.from
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let snap = snaps [indexPath.row]
        
        performSegue(withIdentifier: "viewSegue", sender: snap)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSegue" {
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }
    }
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

