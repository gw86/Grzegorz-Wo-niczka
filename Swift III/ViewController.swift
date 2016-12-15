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
        
        
        //        self.tableViev.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "messageCell")
        
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
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loginList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellIdentifier", for: indexPath) as! SwiftIIITableViewCell
        
        let name = loginList[indexPath.row]
        cell.configure(name: name)
        
        return cell
        
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
