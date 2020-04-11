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
    @IBOutlet weak var loginButton: UIButton!
    
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = textFieldDelegate
        passwordTextField.delegate = textFieldDelegate
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        uiLoading(show: true)
        if userNameTextField.text == "" || passwordTextField.text == "" {
            showAlert("Plase input Email and Password")
            uiLoading(show: false)
        } else {
            OTMClient.login(username: userNameTextField.text ?? "", password: passwordTextField.text ?? "", completion: handerLogin(success:error:))
        }
    }
    
    private func handerLogin(success: Bool, error: Error?) {
        uiLoading(show: false)
        if success {
            performSegue(withIdentifier: K.Segue.mainMap, sender: nil)
        } else {
            showAlert(error?.localizedDescription ?? "Please try again")
        }
    }
    
    @IBAction func signupOnWeb(_ sender: UIButton) {
        let url = OTMClient.Endpoint.signupOnWeb.url
        UIApplication.shared.open(url)
    }
    
    func uiLoading(show enable: Bool) {
        userNameTextField.isEnabled = !enable
        passwordTextField.isEnabled = !enable
        loginButton.isEnabled = !enable
        
        if enable {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

