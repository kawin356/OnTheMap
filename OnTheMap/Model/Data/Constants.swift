//
//  Constants.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 7/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import Foundation

struct K {
    struct NotificationCenter {
        static let updateName = "updatePin"
    }
    struct MyName {
        static let firstName = "Kawin"
        static let lastName = "S"
    }
    struct Segue {
        static let mainMap = "MainShowMapPage"
        static let editMyPin = "EditMyPinPage"
        static let submitPin = "SubmitPinPage"
        static let detailUser = "DetailUserPage"
    }
    struct TableView {
        static let reuseableCell = "Cell"
    }
    struct Storyboard {
        static let editMyPin = "EditMyPinPage"
        static let showDetail = "ShowDetailViewController"
        static let showMapDetail = "MapViewDetailViewController"
        static let mainShowMap = "MainShowMapPage"
        static let rootView = "RootView"
        static let main = "Main"
        static let login = "loginView"
    }
}
