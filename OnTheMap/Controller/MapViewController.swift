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
    
    var studentData: StudentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if StudentModel.student.count == 0 {
            OTMClient.getStudentLocation(completion: handlerStudentLocation(data:error:))
        }
    }
    
    func handlerStudentLocation(data: StudentLocation?, error: Error?) {
        if error == nil {
            guard let data = data else { return }
            studentData = data
            StudentModel.student = data.results
            pinStudentOnMap()
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postMyLocation(_ sender: UIBarButtonItem) {
        showLoginFailure("You Already posted Student location are you sure to replace it ?")
    }
    
    func showLoginFailure(_ message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let actionOverwrite = UIAlertAction(title: "Overwrite", style: .default) { (action) in
            print("Overwrite action")
        }
        alertVC.addAction(actionOverwrite)
        alertVC.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    
    @IBAction func refreshStudentLocationButtonPressed(_ sender: UIBarButtonItem) {
        pinStudentOnMap()
    }
    
    func pinStudentOnMap() {
        
        var annotations = [MKPointAnnotation]()
        
        guard let students = studentData?.results else { return }
        for data in students {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(data.latitude)
            let long = CLLocationDegrees(data.longitude)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = data.firstName
            let last = data.lastName
            let mediaURL = data.mediaURL
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        
        
        // When the array is complete, we add the annotations to the map.
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
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!)
            }
        }
    }
}
