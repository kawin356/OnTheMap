//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 7/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentModel.student.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableView.reuseableCell, for: indexPath)
        
        let firstName = StudentModel.student[indexPath.row].firstName
        let lastName = StudentModel.student[indexPath.row].lastName
        cell.textLabel?.text = "\(firstName)  \(lastName)"
        cell.imageView?.image = UIImage(named: "icon_world")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: K.Storyboard.showDetail) as! ShowDetailViewController
        
        detailVC.selectedStudent = StudentModel.student[indexPath.row]
        
        present(detailVC, animated: true, completion: nil)
    }
}
