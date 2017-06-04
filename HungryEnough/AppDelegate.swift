//
//  AppDelegate.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 6/3/17.
//  Copyright © 2017 AwpSpace. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(ProcessInfo.processInfo.environment["GOOGLE_MAPS_API_KEY"]!)
        return true
    }
}
