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
        OTMClient.logout()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: Notification.Name(K.NotificationCenter.updateName), object: nil)
    }
    
    @IBAction func addLocationButtonPressed(_ sender: UIBarButtonItem) {
        if checkAlreadyPinLocation() {
            let textShow = "You Already posted Student location are you sure to replace it ?"
            showAlert(textShow) {
                self.goToCreatePinViewController()
            }
        } else {
            goToCreatePinViewController()
        }
    }
    
    func goToCreatePinViewController() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: K.Storyboard.editMyPin) {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func checkAlreadyPinLocation() -> Bool {
        for check in StudentModel.student {
            if OTMClient.Auth.accontKey == check.uniqueKey {
                MyLocation.myLocation = check
                return true
            }
        }
        return false
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
