//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Trustin Harris on 3/6/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var ChatTableView: UITableView!
    @IBOutlet weak var MessageField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var objects: [PFObject] = []
    var refreshControl: UIRefreshControl!
    var username = PFUser.current()
    let chatmessage = PFObject(className: "Message")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ChatViewController.didPullToRefresh(_:)), for: .valueChanged)
        ChatTableView.insertSubview(refreshControl, at: 0)
        ChatTableView.dataSource = self
        
        // Auto size row height based on cell autolayout constraints
        ChatTableView.rowHeight = UITableViewAutomaticDimension
        
        // Provide an estimated row height. Used for calculating scroll indicator
        ChatTableView.estimatedRowHeight = 50
        onTimer()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        onTimer()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SendButton(_ sender: Any) {
        
        chatmessage["text"] = MessageField.text ?? ""
        
        
        
        chatmessage.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("The message was saved!")
            } else {
                print("Problem saving message: \(error?.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let object = self.objects[indexPath.row]
        cell.objects = object
        
        if let user = chatmessage["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = chatmessage["user"] as? String
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
    
        

    
        return cell
    }
    
    @objc func onTimer(){
       Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        let query = PFQuery(className: "Message")
        query.limit = 10
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let ReturnedOjbects = objects {
                self.objects = ReturnedOjbects
            } else{
                print(error?.localizedDescription)
            }
        }
        self.ChatTableView.reloadData()
        self.activityIndicator.stopAnimating()
        self.refreshControl.endRefreshing()
        
        }
    
    
    
}


