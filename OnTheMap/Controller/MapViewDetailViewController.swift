//
//  MapViewDetailViewController.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 8/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit
import MapKit

class MapViewDetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
        
    var selectedStudent: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLocation()
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showLocation() {
        let lat = CLLocationDegrees(selectedStudent!.latitude)
        let long = CLLocationDegrees(selectedStudent!.longitude)
        
        //Set zoom to pin
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
        //add detial
        let first = selectedStudent!.firstName
        let last = selectedStudent!.lastName
        let mediaURL = selectedStudent!.mediaURL
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(first) \(last)"
        annotation.subtitle = mediaURL
        
        mapView.addAnnotation(annotation)
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if var toOpen = view.annotation?.subtitle! {
                if !toOpen.hasPrefix("http") {
                    toOpen = "http://\(toOpen)"
                }
                app.open(URL(string: toOpen)!, options: [:], completionHandler: { (isSuccess) in
                        if (isSuccess == false) {
                            self.showAlert("Cannot open this URL maybe It not have Http,Https")
                        }
                    }
                )
            }
        }
    }
    
    private func showAlert(_ message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
