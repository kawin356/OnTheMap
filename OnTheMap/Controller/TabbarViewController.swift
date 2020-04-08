//
//  TabbarViewController.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 8/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        //        let vc = selectedViewController as! MapViewController
        //        vc.pinStudentOnMap()
    }
    
    @IBAction func addLocationButtonPressed(_ sender: UIBarButtonItem) {
        let textShow = "You Already posted Student location are you sure to replace it ?"
        showAlert(textShow) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: K.Storyboard.editMyPin) {
                self.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    
    func showAlert(_ message: String, completion: @escaping () -> Void) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let actionOverwrite = UIAlertAction(title: "Overwrite", style: .default) { (action) in
            completion()
        }
        alertVC.addAction(actionOverwrite)
        alertVC.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
