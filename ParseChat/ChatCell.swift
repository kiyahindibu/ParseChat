//
//  ChatCell.swift
//  ParseChat
//
//  Created by Trustin Harris on 3/8/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var MessageLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var objects : PFObject! {
        didSet {
            
            self.MessageLabel.text = objects["text"] as! String
            
     
    
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
