//
//  LoginLabelTableViewCell.swift
//  Swift - zadania III - 2
//
//  Created by Grzegorz Woźniczka on 12/12/2016.
//  Copyright © 2016 Grzegorz Woźniczka. All rights reserved.
//

import UIKit

class LoginLabelTableViewCell: UITableViewCell {
   
    @IBOutlet weak var userLabel: UILabel!
    
    func configure(name: User) {
        userLabel.text = name.usersLogin
    }
}
