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
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = newLocation
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            guard let response = response else { return }
                //Clear annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                let latitude = response.boundingRegion.center.latitude
                let longitude = response.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.newLocation
                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                self.mapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
        }
    }
}
