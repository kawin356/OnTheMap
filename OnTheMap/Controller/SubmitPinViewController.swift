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
    
    var pin:MKMapItem?
    var newLocation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePinMapView()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let url = urlTextField.text
        
    }
    
    func updatePinMapView() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = newLocation
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
        //    activityIndicator.stopAnimating()
       //     UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.newLocation
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
            
        }
    }
}
