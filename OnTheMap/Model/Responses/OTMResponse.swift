//
//  OTMResponse.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 7/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import Foundation

struct OTMResponse: Codable {
    let status: Int
    let error: String
}

extension OTMResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
