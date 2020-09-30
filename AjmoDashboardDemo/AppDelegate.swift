//
//  AppDelegate.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 9/30/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        
        return true
    }
}

