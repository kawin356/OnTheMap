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
    
    let mapViewDelegate = MapViewDelegate()
        
    override func viewDidLoad() {
        self.mapView.delegate = mapViewDelegate
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
    
    func handlerStudentLocation(success: Bool, error: Error?) {
        if success == true {
            pinStudentOnMap()
        } else {
            showAlert(error?.localizedDescription ?? "Cannot Load Data")
        }
    }
    
    func showAlert(_ message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
        
    func pinStudentOnMap() {
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
    
    
}
