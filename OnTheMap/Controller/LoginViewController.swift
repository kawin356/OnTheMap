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
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        OTMClient.login(username: userNameTextField.text ?? "",
                        password: passwordTextField.text ?? "",
             completion: handerLogin(success:error:))
    }
    
    func handerLogin(success: Bool, error: Error?) {
        if success {
            print("success")
            performSegue(withIdentifier: K.Segue.mainMap, sender: nil)
        } else {
            print("error")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}

