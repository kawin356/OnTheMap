//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 7/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import Foundation

struct StudentLocation: Codable {
    struct Student: Codable {
        let firstName: String
        let lastName: String
        let longitude: Double
        let latitude: Double
        let mapString: String
        let mediaURL: String
        let uniqueKey: String
        let objectId: String
        let createdAt: String
        let updatedAt: String
    }
    let results : [Student]
}
