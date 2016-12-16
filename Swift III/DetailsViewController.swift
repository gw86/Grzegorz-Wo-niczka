//
//  DetailsViewController.swift
//  Swift III
//
//  Created by Grzegorz Woźniczka on 13/12/2016.
//  Copyright © 2016 Grzegorz Woźniczka. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    
    @IBOutlet weak var loginOfUser: UILabel!
    @IBOutlet weak var urlOfUser: UILabel!
    @IBOutlet weak var avatarOfUser: UIImageView!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginOfUser.text = user.login
        urlOfUser.text = user.uRL
        avatarOfUser.image = user.avatar
     
    }
}
