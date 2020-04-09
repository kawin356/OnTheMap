//
//  NotificationCenterUpdate.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 9/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

extension MapViewController {
    
    func subscribeNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(updatePin), name: Notification.Name(K.NotificationCenter.updateName), object: nil)
    }
    
    @objc func updatePin() {
        updateRequest()
    }
}
