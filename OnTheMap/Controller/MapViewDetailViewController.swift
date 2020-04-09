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
    
    let mapViewDelegate = MapViewDelegate()
    
    var selectedStudent: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = mapViewDelegate
        
        showLocation()
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func showLocation() {
        
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
        
        // Here we create the annotation and set its coordiate, title, and subtitle properties
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(first) \(last)"
        annotation.subtitle = mediaURL
        
        mapView.addAnnotation(annotation)
        
        
        
    }
    
}
