//
//  guardForLogins.swift
//  Swift III
//
//  Created by Grzegorz Woźniczka on 13/12/2016.
//  Copyright © 2016 Grzegorz Woźniczka. All rights reserved.
//

import UIKit

struct User {
    
    var usersLogin: String?
    var usersURL: String?
    var usersAvatar: UIImage?
    
    init?(someData: [String: Any]) {
        if let loginName = someData["login"]{
            
            self.usersLogin = loginName as? String
         }
        
        if let html_url = someData["html_url"]{
            self.usersURL = html_url as? String
        }
        if let usersAvatar = someData["avatar_url"]{

            let url = URL(string: usersAvatar as! String)
            let data = try? Data(contentsOf: url!)
            if let image = UIImage(data: data!){
                self.usersAvatar = image
            }
        }
    }
}
