//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 7/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if userNameTextField.text == "" || passwordTextField.text == "" {
            showAlert("Plase input Email and Password")
        } else {
            OTMClient.login(username: userNameTextField.text ?? "",
                                   password: passwordTextField.text ?? "",
                        completion: handerLogin(success:error:))
        }
       
    }
    
    func handerLogin(success: Bool, error: Error?) {
        if success {
            performSegue(withIdentifier: K.Segue.mainMap, sender: nil)
        } else {
            showAlert(error?.localizedDescription ?? "Please try again")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func showAlert(_ message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}

