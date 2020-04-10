//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 7/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateRequest()
        subscribeNotificationCenter()
    }
    
    func updateRequest() {
        if !mapView.annotations.isEmpty {
            mapView.removeAnnotations(mapView.annotations)
        }
        
        OTMClient.getStudentLocation(completion: handlerStudentLocation(success:error:))
    }
    
    private func handlerStudentLocation(success: Bool, error: Error?) {
        if success == true {
            pinStudentOnMap()
        } else {
            showAlert(error?.localizedDescription ?? "Cannot Load Data")
        }
    }
    
    private func showAlert(_ message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
        
    private func pinStudentOnMap() {
        var annotations = [MKPointAnnotation]()
        
        for data in StudentModel.student {
            let lat = CLLocationDegrees(data.latitude)
            let long = CLLocationDegrees(data.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = data.firstName
            let last = data.lastName
            let mediaURL = data.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        self.mapView.addAnnotations(annotations)
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
    
}
