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
        
        let rootVC = Utils.controllerFromStoryboard("Main", id: "MainViewController")
        let nav : UINavigationController = UINavigationController(rootViewController: rootVC)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        Utils.customizeNavigationBarAppearance()
        Utils.customizeStatusBarColor()
        
        return true
    }
}

