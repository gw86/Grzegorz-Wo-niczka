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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViev.estimatedRowHeight = 125
        tableViev.rowHeight = UITableViewAutomaticDimension
        
        
        loginData { (data, error) in
            if error != nil {
                DispatchQueue.main.async{
                    
                    
                    self.showAlert(error: (error?.localizedDescription)! as String)
                }
                return
            }
            if let data = data {
                self.loginList = data
            }
            DispatchQueue.main.async{
                
                self.tableViev.reloadData()
                
            }
        }
    }
    
    func loginData(completion: @escaping ([User]?, Error?) -> ()){
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            
            do {
                if data != data {
                    completion(nil, error)
                }
                let response = response as! HTTPURLResponse
                if response.statusCode != 200 {
                    completion(nil, error)
                }
                var list = [User]()
                let JSON = try JSONSerialization.jsonObject(with: data!, options: []) as! [Dictionary<String, AnyObject>]
                for result in JSON {
                    if let login = User(someData: result) {
                        list.append(login)
                    }
                    
                }
                completion(list, error)
                
            } catch (let serializationError) {
                completion(nil, serializationError)
            }
            
            }.resume()
    }
    
    func showAlert(error: String) {
        
        let alertController = UIAlertController(title: "Alert", message:error, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
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
