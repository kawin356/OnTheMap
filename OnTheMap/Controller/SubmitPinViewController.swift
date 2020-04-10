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
    
    let mapViewDelegate = MapViewDelegate()
    
    var pin:MKMapItem?
    var newLocation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = mapViewDelegate
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
    
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let actionOverwrite = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(actionOverwrite)
        present(alertVC, animated: true, completion: nil)
    }
    
    func handlerCreateNew(success: Bool, error: Error?) {
        if success {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: K.Storyboard.rootView) {
                NotificationCenter.default.post(name: Notification.Name(K.NotificationCenter.updateName), object: nil)
                self.present(vc, animated: true, completion: nil)
            }
        } else {
            showAlert(message: error?.localizedDescription ?? "Canot Save your Location")
        }
    }
    
    func updatePinMapView() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(newLocation) { (response, error) in
            guard let response = response else { return }
                //Clear annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
            if  response.count != 1 {
                let latitude = response[0].location?.coordinate.latitude
                let longitude = response[0].location?.coordinate.latitude
                
                guard let lat = latitude, let long = longitude else {
                    self.showAlert(message: "Cannot Pin in this location")
                    return
                }

                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.newLocation
                annotation.coordinate = CLLocationCoordinate2DMake(lat, long)
                self.mapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
                
            } else if response.count > 1 {
                self.showAlert(message: "Found many location. Plase input specifically location")
            } else if response.count == 0 {
                self.showAlert(message: "Your location not found")
            }
        }
    }
}
