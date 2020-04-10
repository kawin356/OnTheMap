//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 7/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = textFieldDelegate
        passwordTextField.delegate = textFieldDelegate
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        activityIndicator.startAnimating()
        if userNameTextField.text == "" || passwordTextField.text == "" {
            showAlert("Plase input Email and Password")
            activityIndicator.stopAnimating()
        } else {
            OTMClient.login(username: userNameTextField.text ?? "", password: passwordTextField.text ?? "", completion: handerLogin(success:error:))
        }
    }
    
    private func handerLogin(success: Bool, error: Error?) {
        activityIndicator.stopAnimating()
        if success {
            performSegue(withIdentifier: K.Segue.mainMap, sender: nil)
        } else {
            showAlert(error?.localizedDescription ?? "Please try again")
        }
    }

    private func showAlert(_ message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func signupOnWeb(_ sender: UIButton) {
        let url = OTMClient.Endpoint.signupOnWeb.url
        UIApplication.shared.open(url)
    }
}

