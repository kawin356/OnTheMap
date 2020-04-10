//
//  PinLocationViewController.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 8/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit
import MapKit

class PinLocationViewController: UIViewController {
    
    
    @IBOutlet weak var newLocationTextField: UITextField!
    
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newLocationTextField.delegate = textFieldDelegate
    }
    
    @IBAction func findOnTheMap(_ sender: UIButton) {
        if newLocationTextField.text != "" {
            performSegue(withIdentifier: K.Segue.submitPin, sender: nil)
        } else {
            showAlert("Please input your location ! ")
        }
    }
    
    private func showAlert(_ message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.submitPin {
            let VC = segue.destination as! SubmitPinViewController
            VC.newLocation = newLocationTextField.text!
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
