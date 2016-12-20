//
//  ViewController.swift
//  Swift - zadania III - 2
//
//  Created by Grzegorz Woźniczka on 12/12/2016.
//  Copyright © 2016 Grzegorz Woźniczka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViev: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    var loginList: [User] = []
    let URL = API.BaseURL
    
    enum kindOfError: Error{
        case Unknow
        case FailedRequest
        case InvalidResponse
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViev.estimatedRowHeight = 125
        tableViev.rowHeight = UITableViewAutomaticDimension
        
        
        loginData { (data) in
            for result in data {
                if let login = User(someData: result) {
                    self.loginList.append(login)
                    
                }
            }
            DispatchQueue.main.async{
                
                self.tableViev.reloadData()
                
            }
        }
    }
    
    func loginData(completion: @escaping ([Dictionary<String, AnyObject>])throws -> ()){
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            
            try? completion(self.processLoginData(data: data!)!)
            
            
            }.resume()
    }
    
    func processLoginData(data: Data) throws -> [Dictionary<String, AnyObject>]?{
        
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject
        {
            return JSON as? [Dictionary<String, AnyObject>]
        }
        else{
throw kindOfError.InvalidResponse
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loginList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellIdentifier", for: indexPath) as! LoginLabelTableViewCell
        
        let user = loginList[indexPath.row]
        cell.userLabel.text = user.login
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
