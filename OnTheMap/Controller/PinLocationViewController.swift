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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func findOnTheMap(_ sender: UIButton) {
        if newLocationTextField.text != "" {
            performSegue(withIdentifier: K.Segue.submitPin, sender: nil)
        } else {
            alert(string: "Please input your location ! ")
        }
    }
    
    func alert(string: String){
        let alert = UIAlertController(title: nil, message: string, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alert, sender: nil)
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
