//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 7/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentModel.student.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableView.reuseableCell, for: indexPath)
        let firstName = StudentModel.student[indexPath.row].firstName
        let lastName = StudentModel.student[indexPath.row].lastName
        let detail = StudentModel.student[indexPath.row].mapString
        
        cell.textLabel?.text = "\(firstName)  \(lastName)"
        cell.detailTextLabel?.text = detail
        cell.imageView?.image = UIImage(named: "icon_pin")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let app = UIApplication.shared
            var toOpen = StudentModel.student[indexPath.row].mediaURL 
            if !toOpen.hasPrefix("http") {
                toOpen = "http://\(toOpen)"
            }
                app.open(URL(string: toOpen)!, options: [:], completionHandler: { (isSuccess) in
                        if (isSuccess == false) {
                            self.showAlert("Cannot open this URL maybe It not have Http, Https")
                        }
                    })
    }
}
