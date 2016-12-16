//
//  ViewController.swift
//  Swift - zadania III - 2
//
//  Created by Grzegorz Woźniczka on 12/12/2016.
//  Copyright © 2016 Grzegorz Woźniczka. All rights reserved.
//

import UIKit

private let dataManager = DataManager(baseURL: API.BaseURL)

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViev: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    var loginList: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViev.estimatedRowHeight = 125
        tableViev.rowHeight = UITableViewAutomaticDimension
        

        
        dataManager.loginData { (response, error) in
            
            if let results = response as? [Dictionary<String, AnyObject>]{
                for result in results {
                    if let login = User(someData: result) {
                        self.loginList.append(login)
                        
                    }
                }
            }
            DispatchQueue.main.async{
                
                self.tableViev.reloadData()
                
            }
        }
    }
}
var loginLabel: LoginLabelTableViewCell!




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loginList.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellIdentifier", for: indexPath) as! LoginLabelTableViewCell
        
        let name = loginList[indexPath.row]
        configure(name: name)
        
        return cell
        
    }
    
    func configure(name: User) {
        loginLabel.userLabel.text = name.login
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetails", sender: loginList[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! DetailsViewController
        let user = loginList[tableViev.indexPathForSelectedRow!.row]
                
        viewController.user = user
    }
    
}
