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
    
    @IBAction func showAlert() {
        
        let alertController = UIAlertController(title: "AlllleeeerTTT!", message: "What we can do?", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    var loginList: [User] = []
    let URL = API.BaseURL
    
    //    enum kindOfError: Error{
    //        case Unknow
    //        case FailedRequest
    //        case InvalidResponse
    //    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViev.estimatedRowHeight = 125
        tableViev.rowHeight = UITableViewAutomaticDimension
        
        
        loginData { (data, error) in
            if error != nil {
                
                self.showAlert()  //wywietlać
                return
            }
            
            DispatchQueue.main.async{
                
                self.tableViev.reloadData()
                
            }
        }
    }
    
    func loginData(completion: @escaping ([User]?, Error?) -> ()){
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            
            if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200{
                    
                    do {
                        let JSON = try JSONSerialization.jsonObject(with: data, options: []) as! [Dictionary<String, AnyObject>]
                        for result in JSON {
                            if let login = User(someData: result) {
                                self.loginList.append(login)
                                
                            }
                            
                        }
                        completion(self.loginList, error)
                        
                    } catch (let serializationError) {
                        completion(nil, serializationError)
                        
                    }
                    
                    
                } else {
                    completion(nil, error)                }
            }
            
            }.resume()
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
