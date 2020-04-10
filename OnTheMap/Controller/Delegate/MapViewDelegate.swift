////
////  MapViewDelegate.swift
////  OnTheMap
////
////  Created by Kittikawin Sontinarakul on 8/4/2563 BE.
////  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
////
//
//import UIKit
//import MapKit
//
//class MapViewDelegate: NSObject, MKMapViewDelegate {
//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let reuseId = "pin"
//        
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
//
//        if pinView == nil {
//            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            pinView!.canShowCallout = true
//            pinView!.pinTintColor = .red
//            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        else {
//            pinView!.annotation = annotation
//        }
//        
//        return pinView
//    }
//    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        if control == view.rightCalloutAccessoryView {
//            let app = UIApplication.shared
//            if let toOpen = view.annotation?.subtitle! {
//                app.open(URL(string: toOpen)!, options: [:], completionHandler: { (isSuccess) in
//                        if (isSuccess == false) {
//                            self.showAlert(message: "Cannot open this URL maybe It not have Http,Https")
//                        }
//                    }
//                )
//            }
//        }
//    }
//    
//}
