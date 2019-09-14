//
//  AppDelegate.swift
//  DrawLine
//
//  Created by Shashikant Bhadke on 14/09/19.
//  Copyright © 2019 Shashikant Bhadke. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
} //class

