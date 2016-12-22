//
//  guardForLogins.swift
//  Swift III
//
//  Created by Grzegorz Woźniczka on 13/12/2016.
//  Copyright © 2016 Grzegorz Woźniczka. All rights reserved.
//

import UIKit

struct User {
    
    var login: String?
    var uRL: String?
    var avatar: UIImage?
    
    init?(someData: [String: Any]) {
        if let loginName = someData["login"]{
            
            self.login = loginName as? String
        }
        
        if let html_url = someData["html_url"]{
            self.uRL = html_url as? String
        }
        if let avatar = someData["avatar_url"]{
            
            let url = URL(string: avatar as! String)
            let data = try? Data(contentsOf: url!)
            if let image = UIImage(data: data!){
                self.avatar = image
            }
        }
    }
}
