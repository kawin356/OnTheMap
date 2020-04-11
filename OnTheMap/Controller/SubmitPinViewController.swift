//
//  SubmitPinViewController.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 8/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit
import MapKit

class SubmitPinViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
        
    var pin:MKMapItem?
    var newLocation: String!
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlTextField.delegate = textFieldDelegate
        updatePinMapView()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let lat = mapView.annotations[0].coordinate.latitude
        let long = mapView.annotations[0].coordinate.longitude
        
        if let mediaURl = urlTextField.text {
            if MyLocation.myLocation == nil {
            OTMClient.createNewStudentLocation(mapString: newLocation, mediaURL: mediaURl, latitude: lat, longtitude: long, completion: handlerCreateNew(success:error:))
            } else {
                OTMClient.updateStudentLocation(mapString: newLocation, mediaURL: mediaURl, latitude: lat, longtitude: long, completion: handlerCreateNew(success:error:))
            }
        } else {
            let message = "Please enter your URL!"
            showAlert(message: message)
        }
    }
    
    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let actionOverwrite = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(actionOverwrite)
        present(alertVC, animated: true, completion: nil)
    }
    
    func goToMain() {
        let vc = UIStoryboard(name: K.Storyboard.main, bundle: nil)
            .instantiateViewController(identifier: K.Storyboard.rootView)
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.25,
            options: .transitionCrossDissolve,
            animations: nil, completion: nil)
        }
    }
    
    private func handlerCreateNew(success: Bool, error: Error?) {
        if success {
            goToMain()
            NotificationCenter.default.post(name: Notification.Name(K.NotificationCenter.updateName), object: nil)
        } else {
            showAlert(message: error?.localizedDescription ?? "Canot Save your Location")
        }
    }
    
    func updatePinMapView() {
        activityIndecator.startAnimating()
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(newLocation) { (placeMarks, error) in
            guard let placeMarks = placeMarks else {
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                    self.activityIndecator.stopAnimating()
                    return
                }
                return
            }
                //Clear annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
            if  placeMarks.count == 1 {
                let latitude = placeMarks.first?.location?.coordinate.latitude
                let longitude = placeMarks.first?.location?.coordinate.longitude
                
                guard let lat = latitude, let long = longitude else {
                    self.showAlert(message: "Cannot Pin in this location")
                    self.activityIndecator.stopAnimating()
                    return
                }
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.newLocation
                annotation.coordinate = CLLocationCoordinate2DMake(lat, long)
                self.mapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
                let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)

            } else if placeMarks.count == 0 {
                self.showAlert(message: "Your location not found")
            }
        }
        self.activityIndecator.stopAnimating()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
}
