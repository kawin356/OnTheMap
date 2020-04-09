//
//  ShowDetailViewController.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 8/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {
    
    @IBOutlet weak var mapStringTextField: UITextField!
    @IBOutlet weak var mediaUrlTextField: UITextField!
    
    var selectedStudent: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapStringTextField.text = selectedStudent?.mapString
        mediaUrlTextField.text = selectedStudent?.mediaURL
    }
    
    @IBAction func findLocationButtonPressed(_ sender: UIButton) {
        let mapDetailVC = storyboard?.instantiateViewController(withIdentifier: K.Storyboard.showMapDetail) as! MapViewDetailViewController
        mapDetailVC.selectedStudent = selectedStudent
        
        present(mapDetailVC, animated: true, completion: nil)
    }
}
