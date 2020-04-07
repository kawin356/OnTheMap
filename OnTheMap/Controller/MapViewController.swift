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
    
    
    var studentData: StudentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OTMClient.getStudentLocation(completion: handlerStudentLocation(data:error:))
    }
    
    func handlerStudentLocation(data: StudentLocation?, error: Error?) {
        if error != nil {
            studentData = data
        }
    }
}
