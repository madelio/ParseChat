//
//  MessagesTableViewCell.swift
//  ParseChat
//
//  Created by Madel Asistio on 2/23/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    var message: String!
    var user: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
